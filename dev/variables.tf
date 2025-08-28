variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "cluster_name" {
  type    = string
  default = "lanchonete-dev"
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["sa-east-1a","sa-east-1b"]
}

variable "public_subnets" {
  type = list(string)
  default = ["10.20.0.0/20","10.20.16.0/20"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.20.32.0/20","10.20.48.0/20"]
}

variable "node_instance_type" {
  type    = string
  default = "t3.large"
}

variable "node_min_size" { type = number default = 2 }
variable "node_desired_size" { type = number default = 2 }
variable "node_max_size" { type = number default = 5 }

variable "tags" {
  type = map(string)
  default = { Project = "Lanchonete", Env = "dev", IaC = "Terraform" }
}
