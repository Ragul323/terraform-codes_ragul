resource "aws_eks_node_group" "woker_node_1" {
  cluster_name    = aws_eks_cluster.arun.name
  node_group_name = "woker_node_1"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.navin_subnet1.id, aws_subnet.navin_subnet2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  instance_types = [var.worker_instance_type]
}
