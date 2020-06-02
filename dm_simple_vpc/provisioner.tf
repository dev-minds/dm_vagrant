provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.7"
}

terraform {
  required_version = ">= 0.12.12"

  backend "s3" {
    bucket  = "dm-vpc-states"
    key     = "datacentre/dc.tfstat"
    region  = "eu-west-1"
    encrypt = "true"
  }
}