variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "region" {
  description = "AWS Region where resources will be created."
  type        = string
}

variable "cluster" {
  description = "Name of the ECS cluster."
}

variable "vpc_id" {
  description = "AWS VPC id"
}

variable "container_instance_ami" {
  description = "AMI id used to provission container instances."
}

variable "alb_security_group_id" {
  description = "Security group id of application load balancer."
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type to use."
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

variable "private_subnet_ids" {
  description = "The list of private subnets to place the instances in."
  type        = list
}

variable "container_instance_role_name" {
  description = "Contaner instance IAM role name attached to instance profile"
}