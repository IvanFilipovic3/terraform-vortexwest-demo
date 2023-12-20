# ------- AWS VPC NAT Gateway and Elastic IP -------
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = var.subnet_ids[0]
  depends_on    = [aws_eip.elastic_ip]

  tags = {
    Name        = "${var.environment}-NATGW"
    Environment = var.environment
  }
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}