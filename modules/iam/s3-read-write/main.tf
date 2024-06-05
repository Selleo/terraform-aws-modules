data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:DeleteObjectTagging",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${var.bucket_arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:GetBucketTagging",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      var.bucket_arn
    ]
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.name_prefix}-s3-read-write"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy_attachment" "this" {
  name       = "${var.name_prefix}-s3-read-write"
  users      = var.users
  policy_arn = aws_iam_policy.this.arn
}
