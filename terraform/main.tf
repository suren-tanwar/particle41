module "eks_cluster" {
  source = "./modules/eks-cluster"

  aws_region         = var.aws_region
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  cluster_name       = var.cluster_name
  node_instance_type = var.node_instance_type
  desired_size       = var.desired_size
}

