output "cluster_name" { value = module.eks.cluster_id } # módulo fornece cluster_id/cluster_endpoint
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "cluster_security_group_id" { value = module.eks.cluster_security_group_id }
output "oidc_provider_url" { value = module.eks.cluster_oidc_issuer_url }
