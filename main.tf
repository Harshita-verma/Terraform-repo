# module "ec2" {
#         source = "../modules/webserver"
#         ami = "ami-09e2d756e7d78558d"
#         instance_type = "t2.micro"
#         subnet_id  = module.ec2.console_output.id
#         instance_name = "myvm01"
# }    
# module "vpc" {
#   source                                     = "../modules/webserver"
#   vpc_name                                   = "main"
#   region                                     = "eu-west-1"
#   vpc_cidr_block                             = "192.168.0.0/16"
#   tenancy =                                     "default"
#   vpc_id                                      =  "module.webserver.vpc_block"
#   subnet_id                                   = "192.168.1.0/24"
#   interface_vpce_source_security_group_ids   = ["${aws_security_group.web_app.id}"]
#   interface_vpce_subnet_ids                  = ["${aws_subnet.publicsubnets.id}"]
# }

# module "ec2" {
#   source            = "../terraform/ec2"
#   instance_type     = "t2.micro"
#   instance_name     = "myvm01"
#   ami               = "ami-09e2d756e7d78558d"
#   subnet_id         = module.vpc.public_subnet
#   security-group-id = module.security-group.security-group-id
# }

# module "vpc" {
#   source               = "../terraform/ec2/vpc"
#   vpc_name             = "main"
#   main_vpc_cidr        = "10.0.0.0/16"
#   tenancy              = "default"
#   public_subnets       = "10.0.1.0/24"
#   public_subnets_west  = "10.0.2.0/24"
#   private_subnets      = "10.0.3.0/24"
#   private_subnets_west = "10.0.4.0/24"
# }

# module "security-group" {
#   source              = "../terraform/ec2/vpc/security-group"
#   security-group-name = "myvm01-sg"
#   vpc_block           = module.vpc.vpc-block
# }

# module "eks" {
#   source                 = "../terraform/eks-cluster"
#   eks-cluster-name       = "eks-name"
#   eks-role-name          = "eks-role"
#   vpc-private-subnet-id  = module.vpc.private_subnet
#   vpc-public-subnet-id   = module.vpc.public_subnet
#   vpc-public-eu-west-1b  = module.vpc.vpc-public-eu-west-1b
#   vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
# }

# module "worker-node" {
#   source                 = "../terraform/eks-cluster/worker-node"
#   node_role_arn          = "node-role"
#   node_group_name        = "Node-groups"
#   eks_cluster            = module.eks.eks-cluster-name
#   vpc-private-subnet-id  = module.vpc.private_subnet
#   vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
#   capacity_type          = "ON_DEMAND"
#   instance_types         = "t2.small"
#   desired_size           = 2
#   max_size               = 3
#   min_size               = 2
# }

# module "worker-node-second" {
#   source                 = "../terraform/worker-node"
#   node_role_arn          = "node-role"
#   node_group_name        = "Node-groups"
#   eks_cluster            = module.eks.eks-cluster-name
#   vpc-private-subnet-id  = module.vpc.private_subnet
#   vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
#   capacity_type          = "SPOT"
#   instance_types         = "t2.small"
#   desired_size           = 2
#   max_size               = 3
#   min_size               = 2


# }



























