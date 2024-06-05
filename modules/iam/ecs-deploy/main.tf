data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]

    resources = [var.service_arn]
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.name_prefix}-ecs-deploy"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy_attachment" "this" {
  name       = "${var.name_prefix}-ecs-deploy"
  users      = var.users
  policy_arn = aws_iam_policy.this.arn
}
