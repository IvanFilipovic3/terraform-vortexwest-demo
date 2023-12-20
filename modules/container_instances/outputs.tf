output "ecs_instance_security_group_id" {
  value       = aws_security_group.container_instance_sg.id
  description = "Output value of AWS ECS container instance security group id available to other resources."
}

output "service_sg_id" {
  value       = aws_security_group.service_sg.id
  description = "Output value of AWS ECS Service security group id available to other resources."
}