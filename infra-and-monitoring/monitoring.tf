##### web server CPU Monitoring ######
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
     alarm_name                = "gravity-web-server-high-cpu-utilization"
     comparison_operator       = "GreaterThanOrEqualToThreshold"
     evaluation_periods        = "2"
     metric_name               = "CPUUtilization"
     namespace                 = "AWS/EC2"
     period                    = "120" #seconds
     statistic                 = "Average"
     threshold                 = "80"
     alarm_description         = "This metric monitors web server instance cpu utilization"
     insufficient_data_actions = []
dimensions = {
       InstanceId = aws_instance.public-instance.id
     }
}


######## web server Disk Utilization #########
resource "aws_cloudwatch_metric_alarm" "ec2_disk" {
  alarm_name                = "gravity-web-server-high-disk-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 disk utilization"
  insufficient_data_actions = []

   dimensions = {
     path = "/"
    InstanceId = aws_instance.public-instance.id
     device = "xvda1"

    fstype = "xfs"
  }
}
