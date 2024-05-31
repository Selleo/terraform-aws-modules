module "iam_app_xyz" {
  source = "../../modules/user-with-access-key"

  name = "app-xyz-${random_id.id.hex}"

  groups   = [aws_iam_group.app_xyz_s3_access.id]
  policies = [aws_iam_policy.app_xyz_read_ec2.id]
}

resource "random_id" "id" {
  byte_length = 2
}

resource "aws_iam_group" "app_xyz_s3_access" {
  name = "app-xyz-s3-access-${random_id.id.hex}"
}
# ☝️ actual policy is omitted for brevity

resource "aws_iam_policy" "app_xyz_read_ec2" {
  name = "app-xyz-ec2-read-${random_id.id.hex}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# ☝️ actual policy is omitted for brevity
