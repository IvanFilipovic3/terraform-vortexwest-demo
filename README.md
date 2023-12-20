# Terraform vortexwest AWS ECS 

Terraform modules for creating a demo ECS Cluster, networking and realed resources in AWS.

## Usage:

* To create environment cd to one of the directories found in envs directory, either dev, prod or stage.
* Initialize working directory fro example here envs/dev/, with terraform init
* Concept is made with fixture **ecs.tfvars** in each of those directories, where inital parameters are defined, changing these parameters you are influencing how resources are named and created.
* We must define working directory and **ecs.tfvars** fixtures to run plan before applying changes with command terraform plan -input=false -var-file="ecs.tfvars" (if asked specify -chdir and include absolute path e.g. -chdir=Projects/tf/ens/dev)
* Specify environemnt and AWS region to create resources into, in **ecs.tfvars**, using `aws_region` variable.
* Specify the AMI to build your ECS instance from, in **ecs.tfvars**, using `aws_ecs_ami` variable.
* Find the latest recommended Amazon Linux 2 or Amazon Linux 2023 ECS-optimized AMI for current region, or use of the provided options in **ecs.tfvars** using `container_instance_ami` variable:
* Manually find latest recommended ECS-optimized AMI for any region or OS:
  
  Check here: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html

* Export profile as varibale or create aws-cli profile for the account to create resources in, in **ecs.tfvars**, using `aws_profile`.

## Infrastructure diagram

![Terraform module structure](images/infrastructure_diagram.drawio.png)
