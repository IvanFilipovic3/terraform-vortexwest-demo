# ------- AWS Elastic Load balancer target groups -------
resource "aws_lb_target_group" "frontend_tg" {
  name                 = "${var.environment}-frontend-service-tg"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name                 = "${var.environment}-backend-service-tg"
  port                 = 8000
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
  }

  tags = {
    Environment = var.environment
  }
}

# ------- AWS Application load balancer and listeners -------
resource "aws_lb" "alb" {
  name            = "${var.alb_name}"
  internal           = false
  load_balancer_type = "application"
  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "alb_front_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.frontend_tg.id
    type          = "forward"
  }
}

resource "aws_lb_listener" "alb_back_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.backend_tg.id
    type          = "forward"
  }
}

# ------- AWS Application load balancer security group, ingress and egress rules -------
resource "aws_security_group" "alb_sg" {
  name   = "${var.alb_name}-${var.environment}-security-group"
  description = "Application Load Balancer security group"
  vpc_id = var.vpc_id

  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "alb_sg_80_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = var.ingress_cidr_block
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_sg_8000_ingress" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "TCP"
  cidr_blocks       = var.ingress_cidr_block
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.egress_cidr_block
  security_group_id = aws_security_group.alb_sg.id
}