provider "aws" {
  region = var.region
  # Use the default AWS profile from ~/.aws/credentials
  profile = "default" 
}

resource "aws_eks_cluster" "lanchonete_eks_cluster" {
  name     = "lanchonete-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = [aws_subnet.lanchonete_public_subnet_1.id, aws_subnet.lanchonete_public_subnet_2.id, aws_subnet.lanchonete_public_subnet_3.id]
    security_group_ids = [aws_security_group.lanchonete_eks_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_cni_policy,
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "lanchonete-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_security_group" "lanchonete_eks_sg" {
  name        = "lanchonete-eks-cluster-sg"
  description = "Security group for EKS cluster communication"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_node_group" "lanchonete_node_group" {
  cluster_name    = aws_eks_cluster.lanchonete_eks_cluster.name
  node_group_name = "lanchonete-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.lanchonete_public_subnet_1.id, aws_subnet.lanchonete_public_subnet_2.id, aws_subnet.lanchonete_public_subnet_3.id]
  instance_types  = var.instance_types

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]
}

resource "aws_iam_role" "eks_node_role" {
  name = "lanchonete-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# Public Subnets
resource "aws_subnet" "lanchonete_public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.64.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "lanchonete-public-subnet-1"
  }
}

resource "aws_subnet" "lanchonete_public_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.65.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "lanchonete-public-subnet-2"
  }
}

resource "aws_subnet" "lanchonete_public_subnet_3" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.66.0/24"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "lanchonete-public-subnet-3"
  }
}

# Route Table for public subnets
resource "aws_route_table" "lanchonete_public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-05972863c6b195b0a" # Existing Internet Gateway ID
  }

  tags = {
    Name = "lanchonete-public-rt"
  }
}

# Route Table Associations
resource "aws_route_table_association" "lanchonete_public_rt_assoc_1" {
  subnet_id      = aws_subnet.lanchonete_public_subnet_1.id
  route_table_id = aws_route_table.lanchonete_public_rt.id
}

resource "aws_route_table_association" "lanchonete_public_rt_assoc_2" {
  subnet_id      = aws_subnet.lanchonete_public_subnet_2.id
  route_table_id = aws_route_table.lanchonete_public_rt.id
}

resource "aws_route_table_association" "lanchonete_public_rt_assoc_3" {
  subnet_id      = aws_subnet.lanchonete_public_subnet_3.id
  route_table_id = aws_route_table.lanchonete_public_rt.id
}
