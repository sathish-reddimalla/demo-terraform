#########################  start of web  #########################

#
# Cluster || "web"
#
resource "aws_ecs_cluster" "ecs_web" {
    name = "${var.aws_env}-${var.aws_name}-ecs-web"
}

#########################  end of web  #########################