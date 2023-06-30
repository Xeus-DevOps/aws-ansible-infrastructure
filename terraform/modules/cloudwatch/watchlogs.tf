resource "aws_cloudwatch_log_group" "main" {
  name = "${var.env}-logGroup"
  retention_in_days = "0"
}