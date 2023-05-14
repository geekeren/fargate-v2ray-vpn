variable "ddns_subdomain" {
  type        = string
  description = "domain of dynamic DNS, the subdomain you registered at freemyip.com"
}

variable "ddns_token" {
  type        = string
  description = "token of the dymamic dns you registered at freemyip.com"
}

variable "aws_profile" {
  type    = string
  default = "default"
}
