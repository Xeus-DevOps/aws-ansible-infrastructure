resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.env}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "i-012345"
            ]
          ]
          period = 300
          stat   = "Average"
          region = var.location
          title  = "EC2 Instance CPU"
        }
      }
    ]
  })
}