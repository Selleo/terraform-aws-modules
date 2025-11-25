module "iam_app" {
  source  = "../../modules/iam/user-with-access-key"

  name = "name-staging" # TODO adjust name to your project
}

resource "aws_iam_user_policy_attachment" "allow_sending_email" {
  user       = module.iam_app.name # TODO adjust name to your project
  policy_arn = module.ses.send_email_policy_arn
}
