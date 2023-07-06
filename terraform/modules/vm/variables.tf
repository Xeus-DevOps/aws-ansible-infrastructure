variable "subnet_id" {
  description = "aws subnet id for EC2"
}

variable "asg_id" {
  description = "aws_security_interfaces for EC2"
}

variable "tags" {
  description = "tags for EC2"
}

variable "vm_iam_instance_profile" {
  type = string
  description = "Name of IAM instance profile for EC2"
}