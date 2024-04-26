resource "random_id" "prefix" {
  byte_length = 2
}

resource "aws_iam_policy" "this" {
  name   = "cloudfront-deployment-${random_id.prefix.hex}"
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  version = "2012-10-17"

  statement {
    sid = 1

    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
    ]

    resources = var.cloudfront_arns
  }

  statement {
    sid = 2
    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = var.s3_origin_arns
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      var.s3_bucket_arn,
    ]
  }
}
