resource "aws_cloudwatch_dashboard" "vm" {
  dashboard_name = "${var.env}-vm-dashboard"

  dashboard_body = jsonencode({
    "widgets" : [
      {
        "type" : "explorer",
        "x" : 0,
        "y" : 0,
        "width" : 24,
        "height" : 15,
        "properties" : {
          "metrics" : [
            {
              "metricName" : "CPUUtilization",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "DiskReadBytes",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "DiskReadOps",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "DiskWriteBytes",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "DiskWriteOps",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "NetworkIn",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "NetworkOut",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "NetworkPacketsIn",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "NetworkPacketsOut",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Average"
            },
            {
              "metricName" : "StatusCheckFailed",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Sum"
            },
            {
              "metricName" : "StatusCheckFailed_Instance",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Sum"
            },
            {
              "metricName" : "StatusCheckFailed_System",
              "resourceType" : "AWS::EC2::Instance",
              "stat" : "Sum"
            }
          ],
          "aggregateBy" : {
            "key" : "",
            "func" : ""
          },
          "labels" : [
            {
              "key" : "InstanceId",
              "value" : "${var.vm_instance_id}"
            }
          ],
          "widgetOptions" : {
            "legend" : {
              "position" : "bottom"
            },
            "view" : "timeSeries",
            "stacked" : false,
            "rowsPerPage" : 50,
            "widgetsPerRow" : 2
          },
          "period" : 300,
          "splitBy" : "",
          "region" : "ap-southeast-1"
        }
      }
    ]
  })
}
