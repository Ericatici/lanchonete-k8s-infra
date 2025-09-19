resource "aws_ecr_repository" "lanchonete_app_ecr" {
  name                 = "lanchonete-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
