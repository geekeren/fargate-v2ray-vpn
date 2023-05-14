data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpn-vpc"
  cidr = "10.0.0.0/16"

  azs                           = slice(data.aws_availability_zones.available.names, 0, 1)
  public_subnets                = ["10.0.4.0/24"]
  manage_default_security_group = true
  default_security_group_ingress = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "allow gpt-proxy"
      from_port   = 3000
      protocol    = "tcp"
      to_port     = 3000
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "allow v2ray"
      from_port   = 1080
      protocol    = "tcp"
      to_port     = 1080
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "allow v2ray"
      from_port   = 1081
      protocol    = "udp"
      to_port     = 1081
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
