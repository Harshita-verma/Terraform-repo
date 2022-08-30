module "ec2" {
  source            = "../terraform/ec2"
  instance_type     = "t2.micro"
  instance_name     = "myvm01"
  ami               = "ami-09e2d756e7d78558d"
  subnet_id         = module.vpc.public_subnet
  security-group-id = module.security-group.security-group-id
}