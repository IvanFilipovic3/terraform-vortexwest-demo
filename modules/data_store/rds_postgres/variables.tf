variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "vpc_id" {
  description = "VPC id to place subnet in."
}

variable "service_sg_id" {
  description = "Container instance security group id"
}

variable "db_port" {
  description = "Aurora RDS instance port."
}

variable "db_engine" {
  description = "Aurora RDS engine type. e.g. postgres, mysql."
  type        = string
}

variable "db_engine_version" {
  description = "Aurora RDS engine version."
  type        = string
}

variable "multi_az" {
  description = "Aurora RDS replica placement."
  type        = bool
}

variable "db_username" {
  description = "Aurora RDS master username."
  type        = string
}

variable "db_password" {
  description = "Aurora RDS master password."
  type        = string
}

variable "db_instance_class" {
  description = "Aurora RDS instance type."
  type        = string
}

variable "private_subnet_ids" {
  description = "The list of private subnets IDs for Aurora RDS instances to use"
}