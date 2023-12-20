# ------- Local values for local ECS modules -------
locals {
  db_name     = module.database.db_name
  db_endpoint = module.database.db_endpoint
  cluster     = "${var.environment}-ecs"
}

##################################
#       AWS ECS Network      #
##################################
module "network" {
  source = "../network"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

##################################
#       AWS ECS Aurora RDS       #
##################################
module "database" {
  source              = "../../modules/data_store/rds_postgres"
  environment         = var.environment
  vpc_id              = module.network.vpc_id
  service_sg_id       = module.ecs_instances.service_sg_id
  private_subnet_ids  = module.network.private_subnet_ids
  db_port             = var.db_port
  db_engine           = var.db_engine
  db_engine_version   = var.db_engine_version
  multi_az            = var.multi_az
  db_username         = var.db_username
  db_password         = var.db_password
  db_instance_class   = var.db_instance_class       
}

###############################################
#       AWS ECS Application Load balancer     #
###############################################
module "alb" {
  source = "../load_balancer"
  environment       = var.environment
  alb_name          = "${var.environment}-alb"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

##############################
#       AWS ECS Cluster      #
##############################
resource "aws_ecs_cluster" "cluster" {
  name = local.cluster
}

###########################
#       AWS ECS IAM       #
###########################
module "iam" {
  source = "../IAM"
  environment = var.environment
}

##############################################
#       AWS ECS Service task definition      #
##############################################
module "task_definition_frontend" {
  source = "../task_definition"
  environment         = var.environment
  region              = var.region
  service_name        = var.service_name_frontend
  cpu                 = var.cpu
  memory              = var.memory
  execution_role_arn  = module.iam.task_execution_role_arn
  task_role_arn       = module.iam.task_role_arn
  db_name             = null
  db_endpoint         = null
  db_username         = null
  db_password         = null
}

module "task_definition_backend" {
  source = "../task_definition"
  environment         = var.environment
  region              = var.region
  service_name        = var.service_name_backend
  cpu                 = var.cpu
  memory              = var.memory
  execution_role_arn  = module.iam.task_execution_role_arn
  task_role_arn       = module.iam.task_role_arn
  db_name             = local.db_name
  db_endpoint         = local.db_endpoint
  db_username         = var.db_username
  db_password         = var.db_password
}

################################
#       AWS ECS services       #
################################
module "service_frontend" {
  source = "../service"
  environment             = var.environment
  service_name            = var.service_name_frontend
  cluster_id              = aws_ecs_cluster.cluster.id
  task_definition         = module.task_definition_frontend.task_definition_arn
  arn_target_group        = module.alb.frontend_alb_target_group
  desired_task            = var.desired_task
  container_port          = var.container_port_frontend
  private_subnet_ids      = module.network.private_subnet_ids
  service_sg              = module.ecs_instances.service_sg_id
}

module "service_backend" {
  source = "../service"
  environment             = var.environment
  service_name            = var.service_name_backend
  cluster_id              = aws_ecs_cluster.cluster.id
  task_definition         = module.task_definition_backend.task_definition_arn
  arn_target_group        = module.alb.backend_alb_target_group
  desired_task            = var.desired_task
  container_port          = var.container_port_backend
  private_subnet_ids      = module.network.private_subnet_ids
  service_sg              = module.ecs_instances.service_sg_id
}

########################################
#       AWS ECS Container instance     #
########################################
module "ecs_instances" {
  source = "../container_instances"
  environment                  = var.environment
  region                       = var.region
  cluster                      = local.cluster
  private_subnet_ids           = module.network.private_subnet_ids
  container_instance_ami       = var.container_instance_ami
  instance_type                = var.instance_type
  max_size                     = var.max_size
  min_size                     = var.min_size
  desired_capacity             = var.desired_capacity
  vpc_id                       = module.network.vpc_id
  alb_security_group_id        = module.alb.alb_security_group_id
  container_instance_role_name = module.iam.container_instance_role_name
}