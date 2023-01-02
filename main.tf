terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.8.0"
    }
  }
  # backend "s3" {
  #   bucket = "terraform-vnisolutions"
  #   key    = "state/vnisolutions-state.tfstate"
  #   region = "ap-northeast-1"
  #   profile = "vnisolutions"
  # }
}

provider "aws" {
  profile = "default" # AWS CLI Profile name
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"
  env = var.env
  project_name = var.project_name
  region = var.region
}