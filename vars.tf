variable "main_vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "access_key" {}
variable "secret_key" {}

variable "ami_id" {
  description = "this is ubuntu ami id"

  # I am using amazon linux image
  default = "ami-0d75513e7706cf2d9"
}


