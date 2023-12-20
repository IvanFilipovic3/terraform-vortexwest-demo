output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "Output value of AWS VPC id available to other resources."
}

output "vpc_cidr" {
  value       = module.vpc.cidr_block
  description = "Output value of AWS VPC CIDR block available to other resources."
}

output "private_subnet_ids" {
  value       = module.private_subnet.ids
  description = "Output value of AWS private Subnet IDs available to other resources."
}

output "public_subnet_ids" {
  value       = module.public_subnet.ids
  description = "Output value of AWS public Subnet IDs available to other resources."
}