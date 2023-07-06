resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "aws_key_pair" "main" {
  key_name   = "vm-key"
  public_key = tls_private_key.main.public_key_openssh
}

resource "aws_instance" "main" {
  ami             = "ami-0df7a207adb9748c7"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  key_name        = aws_key_pair.main.key_name
  vpc_security_group_ids = [ var.asg_id ]
  iam_instance_profile = var.vm_iam_instance_profile
  monitoring = true

  ebs_block_device {
    volume_size = "8"
    volume_type = "gp2"
    device_name = "/dev/sda1"
  }
  tags = var.tags
}
