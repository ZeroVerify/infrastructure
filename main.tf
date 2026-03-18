locals {
  project    = "zeroverify"
  aws_region = "us-east-1"

  common_tags = {
    Project   = "ZeroVerify"
    ManagedBy = "OpenTofu"
  }
}
