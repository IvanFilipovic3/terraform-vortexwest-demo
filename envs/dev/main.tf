provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "ecs_ec2" {
  source = "../../modules/ecs_ec2"
  environment              = var.environment
  region                   = var.aws_region
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  availability_zones       = var.availability_zones
  container_instance_ami   = var.container_instance_ami
  max_size                 = var.max_size
  min_size                 = var.min_size
  desired_capacity         = var.desired_capacity
  instance_type            = var.instance_type
  service_name_frontend    = var.service_name_frontend
  service_name_backend     = var.service_name_backend
  cpu                      = var.cpu
  memory                   = var.memory
  desired_task             = var.desired_task
  container_port_frontend  = var.container_port_frontend
  container_port_backend   = var.container_port_backend
  db_instance_class        = var.db_instance_class
  db_username              = var.db_username
  db_password              = var.db_password
  db_port                  = var.db_port
  db_engine                = var.db_engine
  db_engine_version        = var.db_engine_version
  multi_az                 = var.multi_az
}