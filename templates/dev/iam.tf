resource "aws_iam_group" "emails" {
  name = "name" # TODO adjust name to your project
}

# users

module "iam_user" {
  source  = "../../modules/iam/user-with-access-key"

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
  source  = "../../modules/ssm/parameters-access"

  context = {
    namespace = "name" # TODO adjust name to your project
    stage     = "dev"
    name      = "name" # TODO adjust name to your project
  }
}