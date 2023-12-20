output "db_name" {
  value       = aws_db_instance.rds_provisioned.db_name
  description = "Output value of AWS Aurora RDS name available to other resources."
}

output "db_endpoint" {
  value       = element(split(":", aws_db_instance.rds_provisioned.endpoint), 0)
  description = "Output value of AWS Aurora RDS instance endpoint available to other resources."
}

