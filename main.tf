locals {
  project    = "zeroverify"
  aws_region = "us-east-1"

  common_tags = {
    Project   = "ZeroVerify"
    ManagedBy = "OpenTofu"
  }
}

module "github_oidc" {
  source = "./modules/github-oidc"

  infrastructure_repositories = [
    "ZeroVerify/infrastructure",
  ]

  lambda_deployment_repositories = [
    "ZeroVerify/bitstring-updater-lambda",
    "ZeroVerify/free-lambda",
    "ZeroVerify/revocation-lambda",
    "ZeroVerify/issuer-lambda",
  ]

  infrastructure_role_name    = "ZeroVerifyGitHubActionsInfra"
  lambda_deployment_role_name = "ZeroVerifyGitHubActionsLambdaDeployment"

  aws_region = local.aws_region
  tags       = local.common_tags
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name   = local.project
  replica_region = "us-west-2"

  tags = local.common_tags
}

module "secrets" {
  source = "./modules/secrets"

  project_name = local.project

  tags = local.common_tags
}

module "lambda_roles" {
  source = "./modules/lambda-roles"

  project_name = local.project

  credentials_table_arn       = module.dynamodb.credentials_table_arn
  bit_indices_table_arn       = module.dynamodb.bit_indices_table_arn
  baby_jubjub_private_key_arn = module.secrets.baby_jubjub_private_key_arn
  hmac_key_arn                = module.secrets.hmac_key_arn

  tags = local.common_tags
}
