# variable "cluster_name" {} 
# variable "container_name" {} 
# variable "ecs_service_name" {} 
# variable "container_definition_file" {} 

variable "containers" {
  type = map
  default = {}
}

variable "aws_region" {}

variable "cluster_name" {}