 module "alb" {
    source = "terraform-aws-modules/alb/aws"
    name = var.alb_name
    load_balancer_type = "application"
    internal = var.internal
    vpc_id = var.vpc_id
    subnets = var.pub_subnet_ids
    security_groups = [module.alb-sg.security_group_id]
    depends_on = [aws_cloudwatch_log_group.example_cw_log_group]
    
    target_groups = [
      {
          name_prefix = "target"
          backend_protocol = "HTTP"
          backend_port = var.container_port
          target_type = "instance"
          health_check = {
          matcher  = "200-499"
          timeout  = 20
      }
      }
    ]

    http_tcp_listeners = [
      {
          port = 80
          protocol = "HTTP"
          target_group_index = 0
      }
    ]
  }
     

