#
# Instance Profile
#
resource "aws_iam_instance_profile" "ecs" {
    name = "${var.aws_env}-${var.aws_name}-instance-profiles"
    role = "${aws_iam_role.ecs_instance_role.name}"
}
