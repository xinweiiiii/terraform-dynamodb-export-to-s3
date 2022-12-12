terraform {
    backend "s3" {
        region = "ap-southeast-1"
        encrypt = true
    }

    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "=4.29.0"
      }
    }
}

provider "aws" {
    region = "ap-southeast-1"
}