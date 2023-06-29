output "subnet_id" {
  value = aws_subnet.vmnet.id
}

output "asg_id" {
  value = aws_security_group.vmnet.id
}