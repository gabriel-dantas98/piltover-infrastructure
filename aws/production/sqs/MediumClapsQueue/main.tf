provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-backend"
    key            = "aws/sqs/prod/MediumClapsQueue/terraform.tfstate"
    region         = "us-east-1"
    }
}

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "MediumClapsQueue"

  create_dlq = true
  redrive_policy = {
    # default is 5 for this module
    maxReceiveCount = 10
  }

  tags = {
    Environment = "prod",
    Squad = "group:default/platform-portal",
    Tribe = "group:default/developer-experience"
  }
}
