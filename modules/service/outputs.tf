output "ecs_service_name" {
  value       = aws_ecs_service.ecs_service.name
  description = "Output value of AWS ECS Service identifier available to other resources."
}
