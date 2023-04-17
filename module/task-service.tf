 
 resource "aws_ecs_service" "example-ecs-service" {
  name = var.ecs_service_name
  cluster = var.cluster_arn
  task_definition = aws_ecs_task_definition.example_task_def.arn
  launch_type = "EC2"
  desired_count = var.ecs_desired_count
  depends_on = [aws_cloudwatch_log_group.example_cw_log_group]
  

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name = var.ecs_service_name
    container_port = var.container_port
  }
} 