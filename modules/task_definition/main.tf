# ------- Local values for ECS services -------
locals {
  task_definition_name = "${var.environment}-${var.service_name}"

  services = {
    service-frontend = {
      container_name = local.task_definition_name
      region = var.region
    }

    service-backend = {
      db_name = var.db_name
      db_endpoint = var.db_endpoint
      db_username = var.db_username
      db_password = var.db_password
      container_name = local.task_definition_name
      region = var.region
    }
  }  
}

# ------- ECS service task definition -------
resource "aws_ecs_task_definition" "task_definition" {
  family                   = local.task_definition_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = templatefile("${path.module}/task-definitions/${var.service_name}.json", {
    global = local.services[var.service_name]
  })
}