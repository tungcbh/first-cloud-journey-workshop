terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket       = "my-terraform-state"
    key          = "rds/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}
