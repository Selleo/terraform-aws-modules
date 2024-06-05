data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = var.cloudfront_arns
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.name_prefix}-cdn-invalidation"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy_attachment" "this" {
  name       = "${var.name_prefix}-cdn-invalidation"
  policy_arn = aws_iam_policy.this.arn
  users      = var.users
}
