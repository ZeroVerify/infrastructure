terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "zeroverify-infrastructure-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "zeroverify-infrastructure-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project   = "ZeroVerify"
      ManagedBy = "OpenTofu"
    }
  }
}
