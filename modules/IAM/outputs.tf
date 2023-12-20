output "container_instance_role_arn" {
  value       = aws_iam_role.container_instance_role.arn
  description = "Output value of AWS container instance IAM role ARN available to other resources."
}

output "container_instance_role_name" {
  value       = aws_iam_role.container_instance_role.name
  description = "Output value of AWS container instance IAM role name available to other resources."
}

output "task_role_arn" {
  value       = aws_iam_role.task_role.arn
  description = "Output value of AWS ECS task IAM role ARN available to other resources."
}

output "task_execution_role_arn" {
  value       = aws_iam_role.task_execution_role.arn
  description = "Output value of AWS ECS task execution IAM role ARN available to other resources."
}