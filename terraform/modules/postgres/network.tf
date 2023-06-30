resource "aws_vpc" "portgres" {
  cidr_block = "172.20.0.0/16"
}

resource "aws_subnet" "postgres1" {
  vpc_id            = aws_vpc.portgres.id
  cidr_block        = "172.20.2.0/24"
  availability_zone = "ap-southeast-1a"
  depends_on = [
    aws_vpc.portgres
  ]
}

resource "aws_subnet" "postgres2" {
  vpc_id            = aws_vpc.portgres.id
  cidr_block        = "172.20.1.0/24"
  availability_zone = "ap-southeast-1b"
  depends_on = [
    aws_vpc.portgres
  ]
}

resource "aws_security_group" "postgres" {
  name   = "${var.env}-postgres"
  vpc_id = aws_vpc.portgres.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_vpc.portgres
  ]
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${var.env}-postgres"
  subnet_ids = [aws_subnet.postgres1.id, aws_subnet.postgres2.id]
  depends_on = [
    aws_subnet.postgres1, aws_subnet.postgres2
  ]
}
