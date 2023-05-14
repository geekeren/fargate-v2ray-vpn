
locals {
  vpn_config = {
    singapore = {
      name   = "新加坡",
      region = "ap-southeast-1"
    }
    japan = {
      name   = "日本",
      region = "ap-northeast-1"
    }
  }
}
module "vpn_singapore" {
  providers = {
    aws = aws.singpore
  }
  source         = "./modules/vpn"
  aws_profile    = var.aws_profile
  ddns_subdomain = var.ddns_subdomain
  ddns_token     = var.ddns_token
}
