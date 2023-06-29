resource "random_string" "credential_postgres" {
  length      = 20
  upper       = false
  special     = false
  min_lower   = 10
  min_numeric = 10
}

resource "aws_db_parameter_group" "postgres_db_param" {
  name   = "${var.env}-postgres"
  family = var.postgres_db_family
  parameter {
    name  = "log_connections"
    value = "1"
  }
  parameter {
    name  = "autovaccum"
    value = "1"
  }
  parameter {
    name  = "client_encoding"
    value = "utf8"
  }
  depends_on = [random_string.credential_postgres]
}

resource "aws_db_instance" "postgres_db_instance" {
    identifier = "${var.env}-postgres"
    instance_class = var.postgres_instance_class
    allocated_storage = var.postgres_allocated_storage
    engine = "postgres"
    engine_version = var.postgres_allocated_storage
    username = "postgresuser"
    password = random_string.credential_postgres.result
    parameter_group_name = aws_db_parameter_group.postgres_db_param.name
    skip_final_snapshot = true
}
