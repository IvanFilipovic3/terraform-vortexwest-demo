variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "service_name" {
  description = "Name for the AWS ECS service"
  type        = string
}

variable "desired_task" {
  description = "Desired number of service tasks to run."
  type        = number
}

variable "cluster_id" {
  description = "AWS ECS cluster id."
  type        = string
}

variable "arn_target_group" {
  description = "ARN of the AWS Target Group attached to ECS service."
  type        = string
}

variable "private_subnet_ids" {
  description = "The list of private subnets IDs for AWS ECS services to use."
}

variable "task_definition" {
  description = "Task definition ARN for ECS service to use."
  type        = string
}

variable "container_port" {
  description = "Port number used by container to associate with load balancer target group."
  type        = number
}

variable "service_sg" {
  description = "Security group of the ECS service communicate with resources in the isolated network and to enable internet access."
}