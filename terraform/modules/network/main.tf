resource "aws_vpc" "vmnet" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "vmnet" {
  vpc_id                  = aws_vpc.vmnet.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  depends_on = [
    aws_vpc.vmnet
  ]
}

resource "aws_internet_gateway" "vmnet" {
  vpc_id     = aws_vpc.vmnet.id
  depends_on = [aws_vpc.vmnet]
}

resource "aws_route_table" "vmnet" {
  vpc_id = aws_vpc.vmnet.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vmnet.id
  }
  depends_on = [
    aws_vpc.vmnet, aws_internet_gateway.vmnet
  ]
}

resource "aws_route_table_association" "vmnet" {
  subnet_id      = aws_subnet.vmnet.id
  route_table_id = aws_route_table.vmnet.id
}

resource "aws_security_group" "vmnet" {
  name   = "vm-security-group"
  vpc_id = aws_vpc.vmnet.id

  ingress {
    description = "SSH for VM"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP for VM"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.vmnet]
}
