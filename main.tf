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
