#########################  start of alerts  #########################

#
# Simple Notification Service (SNS) Topic || "alerts"
#
resource "aws_sns_topic" "sns_alerts" {
    name         = "${var.aws_env}-${var.aws_name}-sns-alerts"
    display_name = "${upper(var.aws_env)}-${upper(var.aws_name)} Notifications"
}

#########################  end of alerts  #########################

