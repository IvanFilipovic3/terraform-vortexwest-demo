output "ids" {
  value       = "${aws_subnet.subnet.*.id}"
  description = "Output value of AWS Subnet IDs available to other resources."
}

output "route_table_ids" {
  value = "${aws_route_table.route_table.*.id}"
  description = "Output value of AWS VPC Route table IDs available to other resources."
}