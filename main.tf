module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "example-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  } 
}

resource "aws_ecs_cluster" "example_cluster" {
   name = var.cluster_name
}

module "ecs-dev" {
   source = "./module"
   depends_on=[ aws_ecs_cluster.example_cluster ]
   for_each = var.containers
   image_name = each.value.image_name
   container_name = each.value.container_name
   ecs_service_name = each.value.ecs_service_name 
   alb_name = each.value.alb_name
   internal = each.value.internal
   ecs_desired_count= each.value.ecs_desired_count
   container_port = each.value.container_port
   task_environment_variables = each.value.envs
   env_value = each.value.envs
   vpc_id = module.vpc.vpc_id
   pub_subnet_ids = module.vpc.public_subnets
   priv_subnet_ids = module.vpc.private_subnets
   cluster_arn = aws_ecs_cluster.example_cluster.id
   cluster_name = aws_ecs_cluster.example_cluster.name
   /* cert_arn = each.value.cert_arn  */
 } 
