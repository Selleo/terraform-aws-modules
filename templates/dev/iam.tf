resource "aws_iam_group" "emails" {
  name = "name" # TODO adjust name to your project
}

# users

module "iam_user" {
  source  = "Selleo/iam/aws//modules/user-with-access-key"
  version = "0.7.0"

  name = "name" # TODO adjust name to your project

  groups = [
    aws_iam_group.emails.name,
  ]
}

# policies

# allows sending emails via SES
resource "aws_iam_group_policy_attachment" "allow_emails_sending" {
  group      = aws_iam_group.emails.name
  policy_arn = module.ses.send_email_policy_arn
}

# allows reading secrets from SSM
module "allow_secrets_access" {
  source  = "Selleo/ssm/aws//modules/parameters-access"
  version = "0.4.0"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "name" # TODO adjust name to your project
  }
}