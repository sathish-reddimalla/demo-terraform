#########################  start of web  #########################

#
# CloudWatch Alarms - CPU Alarm || "web"
#
resource "aws_cloudwatch_metric_alarm" "cwa_ec2_cpu_web" {
    alarm_name          = "${var.aws_env}-${var.aws_name}-cwa-ec2-cpu-web"
    alarm_description   = "CPU Utilization for ${var.aws_env}-${var.aws_name}-asg-web ec2"

    comparison_operator = "GreaterThanOrEqualToThreshold"
    actions_enabled     = true

    evaluation_periods  = "1"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "300"
    statistic           = "Average"
    threshold           = "70"

    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.asg_web.name}"
    }

    alarm_actions       = [
	                        "${aws_autoscaling_policy.asp_cpu_scale_up_web.arn}",
                            "${aws_sns_topic.sns_alerts.arn}"
						  ]
    ok_actions          = [
	                        "${aws_autoscaling_policy.asp_cpu_scale_down_web.arn}",
							"${aws_sns_topic.sns_alerts.arn}"
						  ]
}
