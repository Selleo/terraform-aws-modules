resource "aws_ecr_repository" "this" {
  name = "aws-iam-ecr"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_registry_id" {
  value = aws_ecr_repository.this.registry_id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}

resource "aws_iam_user" "pull" {
  name = "ecr-pull"
}

resource "aws_iam_access_key" "pull" {
  user = aws_iam_user.pull.name
}

output "iam_pull_user_id" {
  value = aws_iam_access_key.pull.id
}

output "iam_pull_user_secret" {
  value     = aws_iam_access_key.pull.secret
  sensitive = true
}

resource "aws_iam_user" "push" {
  name = "ecr-push"
}

resource "aws_iam_access_key" "push" {
  user = aws_iam_user.push.name
}

output "iam_push_user_id" {
  value = aws_iam_access_key.push.id
}

output "iam_push_user_secret" {
  value     = aws_iam_access_key.push.secret
  sensitive = true
}

module "aws_iam_ecr_policy" {
  source      = "../../modules/ecr-pull-push"
  name_prefix = "aws-iam"
  ecr_arn     = aws_ecr_repository.this.arn
  pull_users  = [aws_iam_user.pull.name]
  push_users  = [aws_iam_user.push.name]
}
