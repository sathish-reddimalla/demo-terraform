#########################  start of web  #########################

#
# Target Group || "web"
#
resource "aws_alb_target_group" "target_group_web" {
    name                    = "${var.aws_env}-${var.aws_name}-tg-web-80"
    port                    = 80
    protocol                = "HTTP"
    vpc_id                  = "${aws_vpc.default.id}"

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30

        protocol            = "HTTP"
        path                = "/"
        matcher             = "200"
    }

	deregistration_delay    = 300

    stickiness {
        type                = "lb_cookie"
        cookie_duration     = "86400"
        enabled             = "false"
    }
}

#
# Application Load Balancer (ALB) Listener 80 || "web"
#
resource "aws_alb_listener" "listener_http_web" {
    load_balancer_arn    = "${aws_alb.load_balancer_web.id}"
    port                 = "80"
    protocol             = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.target_group_web.id}"
        type             = "forward"
    }
}


#
# Task Definition || "web"
#
resource "aws_ecs_task_definition" "task_definition_web" {
    family                = "${var.aws_env}-${var.aws_name}-td-web"
    task_role_arn         = "${aws_iam_role.ecs_tasks_role.name}"
    container_definitions = "${file("task-definitions/web.json")}"
}

#
# Service Definition || "web"
#
resource "aws_ecs_service" "service_web" {
    name            = "${var.aws_env}-${var.aws_name}-svc-web"
    cluster         = "${aws_ecs_cluster.ecs_web.id}"
    task_definition = "${aws_ecs_task_definition.task_definition_web.arn}"
    desired_count   = 2

    iam_role        = "${aws_iam_role.ecs_service_role.arn}"

    depends_on = [
        "aws_ecs_cluster.ecs_web",
        "aws_ecs_task_definition.task_definition_web",
        "aws_alb.load_balancer_web",
    ]

    placement_strategy {
        type  = "spread"
        field = "instanceId"
    }

    placement_strategy {
        type  = "spread"
        field = "attribute:ecs.availability-zone"
    }

    placement_constraints {
        type       = "memberOf"
        expression = "attribute:ecs.availability-zone in [${var.availability_zones}]"
    }

    load_balancer {
        target_group_arn = "${aws_alb_target_group.target_group_web.id}"
        container_name   = "${var.aws_env}-${var.aws_name}-ctr-web"
        container_port   = 80
    }
}

#########################  end of web  #########################

