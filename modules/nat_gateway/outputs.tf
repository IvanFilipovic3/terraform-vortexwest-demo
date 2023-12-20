output "ids" {
  value = "${aws_nat_gateway.nat_gateway.*.id}"
  description = "Output value of AWS NAT Gateway id available to other resources."
}