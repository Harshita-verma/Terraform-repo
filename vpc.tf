module "vpc" {
  source               = "../terraform/vpc"
  vpc_name             = "main"
  main_vpc_cidr        = "10.0.0.0/16"
  tenancy              = "default"
  public_subnets       = "10.0.1.0/24"
  public_subnets_west  = "10.0.2.0/24"
  private_subnets      = "10.0.3.0/24"
  private_subnets_west = "10.0.4.0/24"
}