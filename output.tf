 output "ecs_cluster_name" {
  value = var.cluster_name
 }
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.example_cluster.arn
} 
output "loadbalancer_dns_name" {
  value = { for k, g in module.ecs-dev : k => g.loadbalancer_dns_name }
} 
output "loadbalancer_arn" {
  value = { for k, g in module.ecs-dev : k => g.loadbalancer_arn }
}
output "alb-sg-name" {
  value =  { for k, g in module.ecs-dev : k => g.alb_sg_name }
}
output "alb-sg-arn" {
  value = { for k, g in module.ecs-dev : k => g.alb_sg_name }
}
output "ecs-sg-name" {
  value = { for k, g in module.ecs-dev : k => g.ecs_sg_name }
}
output "ecs-sg-arn" {
  value = tomap ({ for k, g in module.ecs-dev : k => g.ecs_sg_arn })
} 
output "servicename" {
  value = tomap({ for k, g in module.ecs-dev : k => g.service_name })
} 