terraform {
  backend "s3" {
    bucket = "teraform-backend-sandbox1-211"
    key    = "sandbox13/backend/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "" 
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}
provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}