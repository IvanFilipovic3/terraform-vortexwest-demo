variable "vpc_cidr" {
  description = "AWS VPC CIDR block."
}

variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Route traffic to any IP address."
}

variable "private_subnet_cidrs" {
  description = "AWS VPC private subnet IP ranges."
  type        = list
}

variable "public_subnet_cidrs" {
  description = "AWS VPC public subnet IP ranges."
  type        = list
}

variable "availability_zones" {
  description = "AWS availability zones to create subnets in."
  type        = list
}