output "instance_id" {
  value = aws_instance.ubuntu.id
}

output "instance_arn" {
  value = aws_instance.ubuntu.arn
}

output "public_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "security_group_id" {
  value = aws_security_group.ec2.id
}
