terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = "seu-bucket-tfstate"
  #   key            = "dev/eks/terraform.tfstate"
  #   region         = "sa-east-1"
  #   dynamodb_table = "seu-lock-table"
  #   encrypt        = true
  # }

  backend "local" {}
}

provider "aws" {
  region = var.aws_region
}
