
terraform {
  backend "s3" {
    bucket = "v2ray-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    profile = "huangzhou"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1" # 日本
  profile = var.aws_profile
}

provider "aws" {
  alias   = "singpore"
  region  = "ap-southeast-1" # 新加坡
  profile = var.aws_profile
}

provider "archive" {}
