module "ci_iam" {
  source  = "../modules/iam/user-with-access-key"

  name = "name-production-ci" # TODO adjust name to your project

  groups = [
    module.cluster.deployment_group,
    module.service.deployment_group,
    module.ecr.deployment_group
  ]

  depends_on = [
    module.ecr
  ]
}

resource "aws_iam_user_policy_attachment" "ci_user" {
  user       = module.ci_iam.name
  policy_arn = aws_iam_policy.ci_user.arn
}

resource "aws_iam_policy" "ci_user" {
  name   = "production-apps-ci-ssm" 
  policy = data.aws_iam_policy_document.ci_user.json
}

data "aws_iam_policy_document" "ci_user" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParametersByPath"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/name/production/api/*"] # TODO adjust name to your project
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:DescribeParameters"
    ]
    resources = ["*"]
  }
}

module "secrets_ci" {
  source  = "../modules/ssm/parameters"

  context = {
    namespace = "name" # TODO adjust namespace to your project
    stage     = "production"
    name      = "ci-secrets"
  }

  secrets = {
    AWS_ACCESS_KEY_ID     = module.ci_iam.key_id
    AWS_SECRET_ACCESS_KEY = module.ci_iam.key_secret
    ECR_URL               = module.ecr.url
    ECS_CLUSTER           = module.cluster.name
    ECS_SERVICE           = module.service.name
  }
}  
