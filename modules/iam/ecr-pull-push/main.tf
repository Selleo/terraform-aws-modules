data "aws_iam_policy_document" "auth" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "pull" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages",
    ]

    resources = [var.ecr_arn]
  }
}

data "aws_iam_policy_document" "push" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = [var.ecr_arn]
  }
}

resource "aws_iam_policy" "auth" {
  name   = "${var.name_prefix}-ecr-auth"
  policy = data.aws_iam_policy_document.auth.json
}

resource "aws_iam_policy_attachment" "auth" {
  name       = "${var.name_prefix}-ecr-auth"
  users      = setunion(var.pull_users, var.push_users)
  policy_arn = aws_iam_policy.auth.arn
}

resource "aws_iam_policy" "pull" {
  name   = "${var.name_prefix}-ecr-pull"
  policy = data.aws_iam_policy_document.pull.json
}

resource "aws_iam_policy_attachment" "pull" {
  count      = length(var.pull_users) > 0 ? 1 : 0
  name       = "${var.name_prefix}-ecr-pull"
  users      = var.pull_users
  policy_arn = aws_iam_policy.pull.arn
}

resource "aws_iam_policy" "push" {
  name   = "${var.name_prefix}-ecr-push"
  policy = data.aws_iam_policy_document.push.json
}

resource "aws_iam_policy_attachment" "push" {
  count      = length(var.push_users) > 0 ? 1 : 0
  name       = "${var.name_prefix}-ecr-push"
  users      = var.push_users
  policy_arn = aws_iam_policy.push.arn
}
