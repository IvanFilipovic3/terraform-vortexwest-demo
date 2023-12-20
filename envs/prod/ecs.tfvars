# AWS Region where resources will be created.
aws_region = "eu-central-1"

# AWS CLI profile for the account to create resources in.
aws_profile = "default"

# Name of the environment we are creating.
environment = "production"

# AWS VPC CIDR block.
# The allowed block size is between a /16 (65,536 addresses) and /28 (16 addresses).
vpc_cidr = "10.0.0.0/16"

# AWS VPC public subnet IP ranges.
public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]

# AWS VPC private subnet IP ranges.
private_subnet_cidrs = ["10.0.50.0/24", "10.0.51.0/24"]

# AWS availability zones to create subnets in.
# To achieve high-availability, decalre at least two availability zones.
availability_zones = ["eu-central-1a", "eu-central-1b"]

# Container instance AMI prefix.
# Leave this value to get the latest amazon 2023 ami, or change prefix to desired OS distribution.
# e.g. amzn2-ami-ecs-*, al2023-ami-ecs-*, 
# Amazon optimized ECS AMIs https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
container_instance_ami = "al2023-ami-ecs-*"

# Maximum number of container instances in the ECS cluster.
# This is the upper boundry for the running container instances in the ASG.
max_size = 1

# Minimum number of container instances in the ECS cluster.
# This is the lower boundry for the running container instances in the ASG.
min_size = 1

# Desired number of container instances in the ECS cluster.
# This is the wanted number of the running container instances in the ASG.
desired_capacity = 1

# Type of the container instance e.g. t2.micro, t2.small.
instance_type = "t2.large"

# Desired name for the frontend service.
service_name_frontend = "service-frontend"

# Desired name for the backend service.
service_name_backend = "service-backend"

# Desired vCPU allocation to service taks.
# Values are defined in units, one unit is represented in the form of 1024,
# 1 vCPU = 1024 units, 0.5 vCPU = 512
cpu = 1024

# Desired memory allocation to service taks.
# Values are defined in units, one unit is represented in the form of 1024,
# 1 GB = 1024 units, 0.5 GB = 512
memory = 1024

# Desired number of service taks to run.
desired_task = 1

# Frontend service container port.
# Port number on which frontend service container is exposed.
container_port_frontend = 80

# Backend service container port.
# Port number on which backend service container is exposed.
container_port_backend = 8000

# Aurora RDS instance type.
# This parameter defines the type of the instance where Aurora RDS is deployed,
# for Aurora serverles instances, this parameter is not valid.
db_instance_class = "db.t3.micro"

# Aurora RDS instance port.
db_port = "5432"

# Aurora RDS engine type. e.g. postgres, mysql.
db_engine = "postgres"

# Aurora RDS engine version.
db_engine_version = "15.5"

# Aurora RDS replica placement.
# This parameter creates another database instance (reader replicas) in the different availability zone,
multi_az = false

# Aurora RDS username password.
# Keep master username in configuration variables only fro demo or testing purposes,
# in any other case use password manager serices like Hashicorp Vault or AWS Secrets manager,
# or export variables before running terraform apply, export TF_VAR_db_username="POSTGRES"
db_username = "POSTGRES"

# Aurora RDS master password.
# Keep master password in configuration variables only fro demo or testing purposes,
# in any other case use password manager serices like Hashicorp Vault or AWS Secrets manager,
# or export variables before running terraform apply, export TF_VAR_db_password="00000000"
db_password = "00000000"
