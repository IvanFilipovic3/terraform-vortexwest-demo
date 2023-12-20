# ------- AWS VPC -------
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-VPC"
    Environment = var.environment
  }
}

# ------- AWS Internet Gateway -------
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id  = aws_vpc.vpc.id
  tags    = {
    Name        = "${var.environment}-IG"
    Environment = var.environment
  }
}