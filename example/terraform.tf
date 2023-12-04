terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = ">= 3.0.0"
      source  = "hashicorp/aws"
    }
    random = {
      version = "~> 3.6.0"
      source  = "hashicorp/random"
    }
  }
}