# ------- AWS VPC module -------
module "vpc" {
  source = "../vpc"
  cidr        = var.vpc_cidr
  environment = var.environment
}

# ------- AWS VPC private subnet module -------
module "private_subnet" {
  source = "../subnet"
  name               = "${var.environment}-private-subnet"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  cidrs              = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

# ------- AWS VPC public and private subnet modules -------
module "public_subnet" {
  source = "../subnet"
  name               = "${var.environment}-public-subnet"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  cidrs              = var.public_subnet_cidrs
  availability_zones = var.availability_zones
}

# ------- AWS VPC NAT Gateway module, Internet gateway and NAT gateway route table routes-------
module "nat_gateway" {
  source       = "../nat_gateway"
  environment  = var.environment 
  subnet_ids   = module.public_subnet.ids
  subnet_count = length(var.public_subnet_cidrs)
}

resource "aws_route" "igw_route" {
  count                  = length(var.public_subnet_cidrs)
  route_table_id         = element(module.public_subnet.route_table_ids, count.index)
  gateway_id             = module.vpc.igw
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_route" "nat_route" {
  count                  = length(var.private_subnet_cidrs)
  route_table_id         = element(module.private_subnet.route_table_ids, count.index)
  nat_gateway_id         = element(module.nat_gateway.ids, count.index)
  destination_cidr_block = var.destination_cidr_block
}