terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}