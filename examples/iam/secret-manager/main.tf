resource "aws_secretsmanager_secret" "secret_no_1" {
  name = "secret_no_1"
}

resource "aws_secretsmanager_secret_version" "kv" {
  secret_id = aws_secretsmanager_secret.secret_no_1.id
  secret_string = jsonencode({
    key1 = "value1"
    key2 = "value2"
    }
  )
}

resource "aws_secretsmanager_secret" "secret_no_2" {
  name = "secret_no_2"
}

resource "tls_private_key" "app" {
  algorithm = "RSA"
}

resource "aws_secretsmanager_secret_version" "bin" {
  secret_id     = aws_secretsmanager_secret.secret_no_2.id
  secret_binary = base64encode(tls_private_key.app.private_key_pem)
}

resource "aws_iam_user" "read_only_user" {
  name = "read_only_user"
}

resource "aws_iam_access_key" "read_only_user" {
  user = aws_iam_user.read_only_user.name
}

output "iam_user1_id" {
  value = aws_iam_access_key.read_only_user.id
}

output "iam_user1_secret" {
  value     = aws_iam_access_key.read_only_user.secret
  sensitive = true
}

resource "aws_iam_user" "full_access_user" {
  name = "full_access_user"
}

resource "aws_iam_access_key" "full_access_user" {
  user = aws_iam_user.full_access_user.name
}

output "iam_user2_id" {
  value = aws_iam_access_key.full_access_user.id
}

output "iam_user2_secret" {
  value     = aws_iam_access_key.full_access_user.secret
  sensitive = true
}

module "aws_iam_secret_manager_policy" {
  source      = "../../modules/secret-manager"
  name_prefix = "aws-iam-secret-manager"
  secrets = [
    aws_secretsmanager_secret.secret_no_1.arn,
    aws_secretsmanager_secret.secret_no_2.arn,
  ]
  read_users  = [aws_iam_user.read_only_user.name]
  write_users = [aws_iam_user.full_access_user.name]
}

