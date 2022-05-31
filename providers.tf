terraform {
   backend "s3" {
    bucket         = "amiblocked.io.tfstate"
    key            = "ecs-platform"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "example-iac-terraform-state-lock-dynamo"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "acm_provider"
  region = "us-east-1"
}
