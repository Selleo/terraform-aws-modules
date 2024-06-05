module "secrets" {
  source = "../../modules/iam/developers"

  users = ["test@test.com"]
}