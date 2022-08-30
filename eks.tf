module "eks" {
  source                 = "../terraform/eks-cluster"
  eks-cluster-name       = "eks-name"
  eks-role-name          = "eks-role"
  vpc-private-subnet-id  = module.vpc.private_subnet
  vpc-public-subnet-id   = module.vpc.public_subnet
  vpc-public-eu-west-1b  = module.vpc.vpc-public-eu-west-1b
  vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
}