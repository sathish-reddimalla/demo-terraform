#########################  start of web  #########################

#
# Repository || "web"
#
resource "aws_ecr_repository" "ecr_web" {
    name = "${var.aws_env}-${var.aws_name}-ecr-web"
}

#########################  end of web  #########################
