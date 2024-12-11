locals {
  tags = {
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
  }

  name = "${var.context.namespace}/${var.context.stage}/${var.context.name}"
  id   = "${var.context.namespace}-${var.context.stage}-${var.context.name}"
}

resource "aws_ecr_repository" "this" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    # kms_key = "TODO" if not specified, AWS will use default KMS for ECR
  }

  tags = local.tags

}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = templatefile("${path.module}/policy/lifecycle.json", {
    image_count   = var.max_image_count
    day_count     = var.expire_untagged_after
    preview_image = var.max_preview_images
  })
}

data "aws_iam_policy_document" "deployment_group" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages",
    ]

    resources = [aws_ecr_repository.this.arn]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = [aws_ecr_repository.this.arn]
  }
}

resource "aws_iam_policy" "deployment_group" {
  name   = "ecr-${local.id}-deployment"
  policy = data.aws_iam_policy_document.deployment_group.json
}

resource "aws_iam_group" "deployment" {
  name = "ecr-${local.id}-deployment"
}

resource "aws_iam_group_policy_attachment" "deployment" {
  group      = aws_iam_group.deployment.name
  policy_arn = aws_iam_policy.deployment_group.arn
}
