terraform {
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