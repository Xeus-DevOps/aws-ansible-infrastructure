resource "random_string" "id_postgres" {
  length  = 20
  upper   = false
  special = false
  lower   = false
  numeric = true
}

resource "random_string" "credential_postgres" {
  length      = 20
  upper       = false
  special     = false
  min_lower   = 10
  min_numeric = 10
}

resource "aws_db_parameter_group" "postgres_db_param" {
  name   = "${var.env}postgresconfig${random_string.id_postgres.result}"
  family = var.postgres_db_family
  parameter {
    name  = "log_connections"
    value = "1"
  }
  parameter {
    name  = "client_encoding"
    value = "utf8"
  }
  depends_on = [random_string.credential_postgres]
}

resource "aws_db_instance" "postgres_db_instance" {
  # Ignore changes on username as it is expected to be changed outside of Terraform or when restoring from snapshot
  # Ignore changes on password as it is expected to be changed outside of Terraform
  lifecycle {
    ignore_changes = [
      username,
      password
    ]
  }

  #  Provisioning the instance DB Postgres
  identifier = "${var.env}postgres${random_string.id_postgres.result}"

  engine         = "postgres"
  engine_version = var.postgres_engine_version
  instance_class = var.postgres_instance_class
  username       = var.postgres_username
  password       = random_string.credential_postgres.result
  port           = 5432

  storage_encrypted     = var.storage_encrypted
  allocated_storage     = var.postgres_allocated_storage
  max_allocated_storage = var.max_allocation_storage
  iops                  = var.iops
  storage_type          = var.storage_type

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [ aws_security_group.postgres.id ]
  publicly_accessible    = false
  parameter_group_name   = aws_db_parameter_group.postgres_db_param.name

  skip_final_snapshot = true
}
