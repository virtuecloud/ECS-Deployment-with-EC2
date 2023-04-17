
output "loadbalancer_dns_name" {
  value = module.alb.lb_dns_name
} 
output "loadbalancer_arn" {
  value = module.alb.lb_arn
}

output "alb_sg_name" {
    value = module.alb-sg.security_group_name
}
output "ecs_sg_name" {
    value = module.ecs-sg.security_group_name
}
output "alb_sg_arn" {
  value = module.alb-sg.security_group_arn
}
output "ecs_sg_arn" {
  value = module.ecs-sg.security_group_arn
}
output "service_name" {
  value = aws_ecs_service.example-ecs-service.name
}