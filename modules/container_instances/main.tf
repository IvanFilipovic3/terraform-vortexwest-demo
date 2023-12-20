# ------- ECS container instance AMI definition -------
data "aws_ami" "latest_ecs_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = [var.container_instance_ami]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ------- ECS container instance profile -------
resource "aws_iam_instance_profile" "container_instance_profile" {
  name = "${var.cluster}-container-instance-profile"
  path = "/"
  role = var.container_instance_role_name
}

# ------- ECS container instance security group, ingress and egress rules -------
resource "aws_security_group" "container_instance_sg" {
  name        = "${var.cluster}-container-instance-security-group"
  description = "ECS container instance security group"
  vpc_id      = var.vpc_id

  tags = {
    Environment   = var.environment
    Cluster       = var.cluster
  }
}

resource "aws_security_group_rule" "container_instance_sg_alb_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = var.alb_security_group_id
  security_group_id        = aws_security_group.container_instance_sg.id
}

resource "aws_security_group_rule" "container_instance_sg_self_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.container_instance_sg.id
  security_group_id        = aws_security_group.container_instance_sg.id
}

resource "aws_security_group_rule" "container_instance_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.container_instance_sg.id
}

# ------- ECS autoscaling group Launch Template -------
resource "aws_launch_template" "container_instance_lt" {
  name = "${var.cluster}-launch-template"
  instance_type = var.instance_type
  image_id = data.aws_ami.latest_ecs_ami.image_id
  vpc_security_group_ids = ["${aws_security_group.container_instance_sg.id}"]
  user_data = base64encode(templatefile("${path.module}/scripts/user_data.sh", {
    cluster_name = var.cluster
  }))

  iam_instance_profile {
    arn = aws_iam_instance_profile.container_instance_profile.arn
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
    Environment   = var.environment
    Cluster       = var.cluster
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# ------- ECS container instance autoscaling group -------
resource "aws_autoscaling_group" "asg" {
  name                 = "${var.cluster}-asg"
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  force_delete         = true
  vpc_zone_identifier  = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.container_instance_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster}-container-instance"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Cluster"
    value               = var.cluster
    propagate_at_launch = "true"
  }

  lifecycle {
    create_before_destroy = true
  }  
}  

# ------- ECS services security group, ingress and egress rules -------
resource "aws_security_group" "service_sg" {
  name   = "${var.environment}-app-security-group"
  vpc_id = var.vpc_id

  tags = {
    Environment = var.environment
    Cluster       = var.cluster
  }
}

resource "aws_security_group_rule" "service_sg_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  source_security_group_id = var.alb_security_group_id
  security_group_id = aws_security_group.service_sg.id
}

resource "aws_security_group_rule" "service_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.service_sg.id
}