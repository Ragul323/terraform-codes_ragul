resource "aws_eks_cluster" "arun" {
  name        = "arun"
  role_arn    = aws_iam_role.eks_cluster_role.arn
  depends_on  = [aws_vpc.navin.id]

  vpc_config {
    subnet_ids = [aws_subnet.navin_subnet1.id, aws_subnet.navin_subnet2.id, aws_subnet.navin_subnet3.id]
  }
  version = "1.26"
}



