variable "environment" {
  description = "Name of the environment we are creating."
  type        = string
}

variable "subnet_ids" {
  type        = list
  description = "List of subnets in which to place the NAT Gateway"
}

variable "subnet_count" {
  description = "Number of subnet IDs."
}