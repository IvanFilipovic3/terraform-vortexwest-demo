# ------- ECS database security group, ingress rule -------
resource "aws_security_group" "database_sg" {
  name        = "${var.environment}-database-security-group"
  description = "RDS instance security group"
  vpc_id      = var.vpc_id

  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "database_sg_ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  source_security_group_id = var.service_sg_id
  security_group_id        = aws_security_group.database_sg.id
}

# ------- ECS database subnet group-------
resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "main"
  subnet_ids = [var.private_subnet_ids[0], var.private_subnet_ids[1]]
}

# ------- ECS database provissioned instance -------
resource "aws_db_instance" "rds_provisioned" {
  identifier              = var.environment
  db_name                 = var.environment
  username                = var.db_username
  password                = var.db_password
  port                    = var.db_port
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = "20"
  storage_encrypted       = false
  vpc_security_group_ids  = [aws_security_group.database_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  multi_az                = var.multi_az
  storage_type            = "gp3"
  publicly_accessible     = false
  backup_retention_period = 7
  skip_final_snapshot     = true

  tags = {
    Environment = var.environment
  }
}