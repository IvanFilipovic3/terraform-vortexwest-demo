variable "aws_region" {
  description = "AWS Region where resources will be created."
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile for the account to create resources in."
  type        = string
}

variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "vpc_cidr" {
  description = "AWS VPC CIDR block."
}

variable "public_subnet_cidrs" {
  description = "AWS VPC public subnet IP ranges."
  type        = list
}

variable "private_subnet_cidrs" {
  description = "AWS VPC private subnet IP ranges."
  type        = list
}

variable "availability_zones" {
  description = "AWS availability zones to create subnets in."
  type        = list
}

variable "container_instance_ami" {
  description = "Container instance AMI name."
  type        = string
}

variable "max_size" {
  description = "Maximum number of container instances in the ECS cluster."
  type        = number
}

variable "min_size" {
  description = "Minimum number of container instances in the ECS cluster."
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of container instances in the ECS cluster."
  type        = number
}

variable "instance_type" {
  description = "Type of the container instance e.g. t2.micro, t2.small."
  type        = string
}

variable "service_name_frontend" {
  description = "Desired name for the frontend service."
  type        = string
}

variable "service_name_backend" {
  description = "Desired name for the backend service."
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

variable "desired_task" {
  description = "Desired number of service tasks to run."
  type        = number
}

variable "container_port_frontend" {
  description = "Frontend service container port."
  type        = number
}

variable "container_port_backend" {
  description = "Backend service container port."
  type        = number
}

variable "db_instance_class" {
  description = "Aurora RDS instance type."
  type        = string
}

variable "db_port" {
  description = "Aurora RDS instance port."
  type        = string
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
  type = string
}