#########################  start of web  #########################

#
# Simple Scaling Up Policy || "web"
#
resource "aws_autoscaling_policy" "asp_cpu_scale_up_web" {
    name                    = "${var.aws_env}-${var.aws_name}-asp-scaleup-web"
    scaling_adjustment      = 1
    adjustment_type         = "ChangeInCapacity"
    autoscaling_group_name  = "${aws_autoscaling_group.asg_web.name}"
    cooldown                = 300
    policy_type             = "SimpleScaling"
}

#
# Simple Scaling Down Policy || "web"
#
resource "aws_autoscaling_policy" "asp_cpu_scale_down_web" {
    name                    = "${var.aws_env}-${var.aws_name}-asp-scaledown-web"
    scaling_adjustment      = -1
    adjustment_type         = "ChangeInCapacity"
    autoscaling_group_name  = "${aws_autoscaling_group.asg_web.name}"
    cooldown                = 300
    policy_type             = "SimpleScaling"
}

#########################  end of web  #########################