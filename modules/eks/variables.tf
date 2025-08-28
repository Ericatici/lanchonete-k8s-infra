variable "cluster_name" { 
    type = string 
}
variable "cluster_version" { 
    type = string 
    default = "1.29" 
}
variable "vpc_id" { 
    type = string 
}
variable "subnet_ids" { 
    type = list(string) 
}
variable "node_instance_types" { 
    type = list(string) 
    default = ["t3.micro"] 
}
variable "node_min_size" { 
    type = number 
    default = 2 
}
variable "node_desired_size" { 
    type = number 
    default = 2 
}
variable "node_max_size" { 
    type = number 
    default = 5 
}
variable "tags" { 
    type = map(string) 
    default = {} 
}
