variable "alb_name" {
  description = "Name of the AWS Load Balancer"
}

variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet ids."
  type        = list
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "deregistration_delay" {
  default     = "150"
  description = "ALB target deregistration delay"
}

variable "health_check_path" {
  default     = "/swagger/"
  description = "Default health check path"
}

variable "ingress_cidr_block" {
  default     = ["0.0.0.0/0"]
  description = "Specify cidr block for inbound traffic"
  type        = list
}

variable "egress_cidr_block" {
  default     = ["0.0.0.0/0"]
  description = "Specify cidr block for outbound traffic"
  type        = list
}
