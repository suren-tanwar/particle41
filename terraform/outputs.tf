output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "vpc_id" {
  value = module.eks_cluster.vpc_id
}

output "private_subnets" {
  value = module.eks_cluster.private_subnets
}