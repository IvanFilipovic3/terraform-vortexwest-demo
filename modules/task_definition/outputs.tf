output "task_definition_arn" {
  value       = aws_ecs_task_definition.task_definition.arn
  description = "Output value of AWS Task definition ARN available to other resources."
}

output "task_definition_family" {
  value       = aws_ecs_task_definition.task_definition.family
  description = "Output value of AWS Task definition family identifier available to other resources."
}