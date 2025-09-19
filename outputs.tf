output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.lanchonete_eks_cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.lanchonete_eks_cluster.endpoint
}

output "kubeconfig_certificate_authority_data" {
  description = "The base64 encoded certificate authority data required to communicate with your cluster."
  value       = aws_eks_cluster.lanchonete_eks_cluster.certificate_authority[0].data
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository for lanchonete-app"
  value       = aws_ecr_repository.lanchonete_app_ecr.repository_url
}

output "eks_cluster_security_group_id" {
  description = "The ID of the EKS cluster security group"
  value       = aws_security_group.lanchonete_eks_sg.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs created for the EKS cluster"
  value       = [aws_subnet.lanchonete_public_subnet_1.id, aws_subnet.lanchonete_public_subnet_2.id, aws_subnet.lanchonete_public_subnet_3.id]
}
