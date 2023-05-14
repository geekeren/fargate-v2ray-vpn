
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  # 用于和 VPN 无关的基础设施
  alias = "global"
  region = "ap-northeast-1" # 日本
  profile = var.aws_profile
}

provider "aws" {
  region = "ap-southeast-1" # 新加坡
  profile = var.aws_profile
}

provider "archive" {}