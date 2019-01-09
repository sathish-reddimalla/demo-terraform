#########################  start of web  #########################

#
# Application Load Balancer (ALB) || "web"
#
resource "aws_alb" "load_balancer_web" {
    name            = "${var.aws_env}-${var.aws_name}-alb-web"
    internal        = "false"
    subnets         = ["${aws_subnet.us-east-1a-public.id}","${aws_subnet.us-east-1b-public.id}"]
    security_groups = ["${aws_security_group.web.id}"]

    tags {
        Name        = "${var.aws_env}-${var.aws_name}-alb-web"
    }
}

#########################  end of web  #########################