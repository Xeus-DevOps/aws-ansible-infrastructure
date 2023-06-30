resource "random_string" "s3_origin_identifier" {
  numeric = true
  upper = false
  lower = false
  special = false
  length = 10
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.env}bucket${random_string.s3_origin_identifier.result}"
}