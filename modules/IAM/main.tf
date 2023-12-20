# ------- ECS task IAM role, task execution IAM role and policies -------
resource "aws_iam_role" "task_role" {
  name               = "${var.environment}-task-role"
  assume_role_policy = jsonencode({
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
})

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = "${var.environment}-task-policy"
  policy = file("${path.module}/policies/task-role-policy.json")
  role   = aws_iam_role.task_role.id
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.environment}-task-execution-role"
  assume_role_policy = jsonencode({
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
})

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "task_execution_role_policy" {
  name   = "${var.environment}-task-execution-policy"
  policy = file("${path.module}/policies/task-execution-policy.json")
  role   = aws_iam_role.task_execution_role.id
}

# ------- ECS container instance IAM role and policies -------
resource "aws_iam_role" "container_instance_role" {
  name = "${var.environment}-container-instance-role"
  assume_role_policy = jsonencode({
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
})

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "container_instance_policy" {
  name   = "${var.environment}-container-instance-policy"
  policy = file("${path.module}/policies/container-instance-policy.json")
  role   = aws_iam_role.container_instance_role.id
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = aws_iam_role.container_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ssm_role" {
  role       = aws_iam_role.container_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}