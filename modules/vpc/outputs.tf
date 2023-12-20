output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "Output value of AWS VPC id available to other resources."
}

output "cidr_block" {
  value       = aws_vpc.vpc.cidr_block
  description = "Output value of AWS VPC CIDR block available to other resources."
}

output "igw" {
  value       = aws_internet_gateway.internet_gateway.id
  description = "Output value of AWS Internet Gateway id available to other resources."
}