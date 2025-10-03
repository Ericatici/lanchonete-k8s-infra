resource "aws_ecr_repository" "lanchonete_app_ecr" {
  name                 = "lanchonete-app"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = "dev"
    Project     = "lanchonete"
  }
}


