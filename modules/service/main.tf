# ------- Local values for ECS services -------
locals {
  service_name = "${var.environment}-${var.service_name}"
}

# ------- ECS service -------
resource "aws_ecs_service" "ecs_service" {
  name                              = local.service_name
  cluster                           = var.cluster_id
  task_definition                   = var.task_definition
  desired_count                     = var.desired_task
  enable_ecs_managed_tags           = true
  propagate_tags                    = "SERVICE"
  health_check_grace_period_seconds = 120
  launch_type                       = "EC2"

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  network_configuration {
    assign_public_ip  = false
    security_groups   = [var.service_sg]
    subnets           = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = var.arn_target_group
    container_name   = local.service_name
    container_port   = var.container_port
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }

}

resource "aws_cloudwatch_log_group" "cw_log_group" {
  name              = "/ecs/${local.service_name}"
  retention_in_days = 30
}