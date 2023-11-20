terraform {
  backend "s3" {
    bucket = "teraform-backend-sandbox1-211"
    key    = "sandbox13/database/terraform.tfstate"
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