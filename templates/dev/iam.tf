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
