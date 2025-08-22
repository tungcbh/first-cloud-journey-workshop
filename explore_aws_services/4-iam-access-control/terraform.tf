terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }

  # backend "local" {
  #   path = "terraform.tfstate"
  # }

  backend "s3" {
    bucket         = "bucket-name"
    key            = "explore_aws_services/2-manage-usage-cost/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
