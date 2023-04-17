data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "${var.ecs_service_name}ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}


resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.ecs_service_name}ecsInstanceProfile"
  role = aws_iam_role.ecs_agent.name
}

data "aws_ami" "default" {
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.202*-x86_64-ebs"]
  }

  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_configuration" "ecs_launch_config" {
    name                 = "${var.ecs_service_name}-launch-config"
    associate_public_ip_address = true
    image_id             = data.aws_ami.default.id
    iam_instance_profile = aws_iam_instance_profile.ecs.name
    security_groups      = [module.ecs-sg.security_group_id]
    user_data = <<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=testcluster >> /etc/ecs/ecs.config
      EOF

    instance_type        = "t3.medium"
    key_name             = "testt"
    lifecycle {
       create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    name                      = "${var.ecs_service_name}auto-scaling-group"
    vpc_zone_identifier       = var.priv_subnet_ids
    launch_configuration      = aws_launch_configuration.ecs_launch_config.name

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 3
    health_check_grace_period = 300
    health_check_type         = "EC2"
    target_group_arns    = module.alb.target_group_arns
    termination_policies = ["OldestInstance"]
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.example-ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

}

resource "aws_appautoscaling_policy" "my_policy" {
  name               = "${var.ecs_service_name}auto-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  service_namespace  = "ecs"
  scalable_dimension = "${aws_appautoscaling_target.ecs_target.scalable_dimension}"
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 50.0
  }
}