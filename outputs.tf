output "ec2_public_ip" {
  value = aws_instance.ragul_instance.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.navin_rds.endpoint
}
output "eks_cluster_name" {
  value       = module.eks.cluster_id
}
output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
}
output "eks_cluster_arn" {
  value       = module.eks.cluster_arn
}
output "eks_worker_node_group_name" {
  value       = aws_eks_node_group.eks_workers.node_group_name
}
output "eks_worker_node_instance_ids" {
  value       = aws_eks_node_group.eks_workers.resources[*].instances[*].instance_id
}
output "eks_worker_node_security_group_id" {
  value       = aws_eks_node_group.eks_workers.resources[*].security_group_id
}
