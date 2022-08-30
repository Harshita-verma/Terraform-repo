module "security-group" {
  source              = "../terraform/vpc/security-group"
  security-group-name = "myvm01-sg"
  vpc_block           = module.vpc.vpc-block
}