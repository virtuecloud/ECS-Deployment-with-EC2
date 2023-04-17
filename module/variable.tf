variable "cluster_name" {}
variable "container_port" {}
variable "ecs_desired_count" {}
variable "alb_name" {}
/* variable "cert_arn" {} */
variable "container_name" {} 
variable "ecs_service_name" {}
variable "vpc_id" {}
variable "pub_subnet_ids" {}
variable "priv_subnet_ids" {}
variable "cluster_arn" {}
# variable "log_name" {}
# variable "cluster_count" {}
# variable "family_name" {}
variable "internal" {}
variable "image_name" {}
variable "task_environment_variables" {
  default = []
}
variable "env_value" {} 
