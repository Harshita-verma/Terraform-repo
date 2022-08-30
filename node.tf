module "worker-node-ON_DEMAND" {
  source                 = "../terraform/eks-cluster/worker-node"
  iam-role-name          = "eks-node-group-ondemand"
  key_name               = "worker-node-ondemand-key"
  node_role_arn          = "node-role"
  node_group_name        = "Node-groups-ondemand"
  eks_cluster            = module.eks.eks-cluster-name
  vpc-private-subnet-id  = module.vpc.private_subnet
  vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
  capacity_type          = "ON_DEMAND"
  instance_types         = "t2.small"
  desired_size           = 2
  max_size               = 3
  min_size               = 2
}


module "worker-node-SPOT" {
  source                 = "../terraform/eks-cluster/worker-node"
  iam-role-name          = "eks-node-group-spot"
  key_name               = "worker-node-spot-key"
  node_role_arn          = "node-role"
  node_group_name        = "Node-groups-spot"
  eks_cluster            = module.eks.eks-cluster-name
  vpc-private-subnet-id  = module.vpc.private_subnet
  vpc-private-eu-west-1b = module.vpc.vpc-private-eu-west-1b
  capacity_type          = "SPOT"
  instance_types         = "t2.small"
  desired_size           = 2
  max_size               = 3
  min_size               = 2
}

