module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpn-vpc"
  cidr = "10.0.0.0/16"

  azs                           = ["ap-east-1a", "ap-east-1b", "ap-east-1c"]
  public_subnets                = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  manage_default_security_group = true
  default_security_group_ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "allow v2ray"
      from_port   = 1080
      protocol    = "tcp"
      to_port     = 1080
    },
  ]
  default_security_group_egress = [
    {
      cidr_blocks = "0.0.0.0/0"
      protocol    = "-1"
    },
  ]
  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
