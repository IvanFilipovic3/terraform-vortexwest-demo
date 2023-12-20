output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "Output value of AWS ALB id available to other resources."
}

output "frontend_alb_target_group" {
  value       = aws_lb_target_group.frontend_tg.arn
  description = "Output value of AWS ALB frontend target group ARN available to other resources."
}

output "backend_alb_target_group" {
  value       = aws_lb_target_group.backend_tg.arn
  description = "Output value of AWS ALB backend target group ARN available to other resources."
}