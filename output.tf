output "ecs_cluster_name" {
  value = var.cluster_name
}
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.example_cluster.arn
}
output "loadbalancer_dns_name" {
  value = module.ecs-dev.loadbalancer_dns_name
}
output "loadbalancer_arn" {
  value = module.ecs-dev.loadbalancer_arn
}
output "alb-sg-name" {
  value =  module.ecs-dev.alb_sg_name
}
output "alb-sg-arn" {
  value = module.ecs-dev.alb_sg_arn
}
output "ecs-sg-name" {
  value = module.ecs-dev.ecs_sg_name
}
output "ecs-sg-arn" {
  value = module.ecs-dev.ecs_sg_arn
}
output "service_name" {
  value = module.ecs-dev.service_name
}