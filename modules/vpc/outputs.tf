output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}
