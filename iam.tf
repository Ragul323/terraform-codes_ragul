resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.key
}
resource "aws_iam_access_key" "programmatic_access" {
  for_each = toset(var.iam_users)
  user     = aws_iam_user.users[each.key].name
}
resource "aws_iam_user_policy_attachment" "attach_policy" {
  for_each   = toset(var.iam_users)
  user       = aws_iam_user.users[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

--------------------eks role-------------------------------------
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
-----------------msk role--------------------------------
resource "aws_iam_role" "msk_iam_role" {
  name = "MSK_IAM_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "kafka.amazonaws.com"
        }
      }
    ]
  })
}
----------------------------eks------------------------------------
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "eks_ec2_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

-------------------------msk-----------------------------------------------
resource "aws_iam_role_policy_attachment" "msk_iam_role_policy" {
  role       = aws_iam_role.msk_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}

----------------------------s3-----------------------------------------
resource "aws_iam_policy" "kannan_full_access" {
  name        = "KannanFullAccessToPuneTasks"
  description = "Full access to S3 bucket pune-tasks for user kannan"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::pune-tasks",
          "arn:aws:s3:::pune-tasks/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "read_only_access" {
  name        = "ReadOnlyAccessToPuneTasks"
  description = "Read-only access to S3 bucket pune-tasks for users lokesh and platform"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::pune-tasks",
          "arn:aws:s3:::pune-tasks/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "kannan_full_access_attach" {
  user       = "kannan"
  policy_arn = aws_iam_policy.kannan_full_access.arn
}
resource "aws_iam_user_policy_attachment" "lokesh_read_only_attach" {
  user       = "lokesh"
  policy_arn = aws_iam_policy.read_only_access.arn
}
resource "aws_iam_user_policy_attachment" "platform_read_only_attach" {
  user       = "platform"
  policy_arn = aws_iam_policy.read_only_access.arn
}

-------------------------lambda--------------------------------

resource "aws_iam_role" "lambda_rds_role" {
  name = "lambda-rds-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_policy" "lambda_rds_policy" {
  name = "lambda-rds-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "rds:StartDBInstance",
          "rds:StopDBInstance"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_rds_role_attach" {
  role       = aws_iam_role.lambda_rds_role.name
  policy_arn = aws_iam_policy.lambda_rds_policy.arn
}

---------------------------stop-------------------
resource "aws_iam_role" "lambda_rds_stop_role" {
  name = "lambda_rds_stop_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_rds_stop_policy" {
  name = "lambda_rds_stop_policy"
  role = aws_iam_role.lambda_rds_stop_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds:StopDBInstance"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}


