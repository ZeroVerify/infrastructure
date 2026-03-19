locals {
  project            = "zeroverify"
  aws_region         = "us-east-1"
  domain_name        = "zeroverify.net"
  cloudflare_zone_id = "1263138b7d733aa1804fdc0b39c97c23"

  common_tags = {
    Project   = "ZeroVerify"
    ManagedBy = "OpenTofu"
  }
}

module "storage" {
  source = "./modules/storage"

  project_name = local.project

  tags = local.common_tags
}

module "dns" {
  source = "./modules/dns"

  domain_name        = local.domain_name
  cloudflare_zone_id = local.cloudflare_zone_id

  tags = local.common_tags
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

  aws_region                      = local.aws_region
  deployment_artifacts_bucket_arn = module.storage.deployment_artifacts_bucket_arn
  tags                            = local.common_tags
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

module "lambda" {
  source = "./modules/lambda"

  project_name = local.project

  deployment_artifacts_bucket = module.storage.deployment_artifacts_bucket_name

  issuer_lambda_role_arn            = module.lambda_roles.issuer_lambda_role_arn
  revocation_lambda_role_arn        = module.lambda_roles.revocation_lambda_role_arn
  free_lambda_role_arn              = module.lambda_roles.free_lambda_role_arn
  bitstring_updater_lambda_role_arn = module.lambda_roles.bitstring_updater_lambda_role_arn

  credentials_table_stream_arn = module.dynamodb.credentials_table_stream_arn
  bit_indices_table_stream_arn = module.dynamodb.bit_indices_table_stream_arn

  tags = local.common_tags

  depends_on = [module.storage]
}
