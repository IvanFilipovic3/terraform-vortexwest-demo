variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "service_name" {
  description = "Service name used for task definition family name and for container name."
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role that will be assumed by ECS containers or task managing agents to call AWS APIs."
  type        = string
}

variable "task_role_arn" {
  description = "IAM role that will be assumed by contaniers in the task to call AWS APIs."
  type        = string
}

variable "cpu" {
  description = "Desired vCPU allocation to service taks."
  type        = number
}

variable "memory" {
  description = "Desired RAM allocation to service taks."
  type        = number
}

variable "region" {
  description = "AWS Region where resources will be created."
  type        = string
}

variable "db_name" {
  description = "Aurora RDS name"
  type        = string
}

variable "db_username" {
  description = "Aurora RDS master username."
  type        = string
}

variable "db_password" {
  description = "Aurora RDS master password."
  type        = string
}

variable "db_endpoint" {
  description = "Aurora RDS instance endpoint"
  type        = string
}