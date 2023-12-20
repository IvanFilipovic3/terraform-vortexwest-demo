variable "name" {
  description = "Name of the subnet."
}

variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "cidrs" {
  type        = list
  description = "List of every CIDR block."
}

variable "availability_zones" {
  description = "AWS availability zones to create subnets in."
  type        = list
}

variable "vpc_id" {
  description = "VPC id to place subnet in."
}