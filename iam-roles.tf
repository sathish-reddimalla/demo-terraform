#
# ECS Instance Role
#
resource "aws_iam_role" "ecs_instance_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsInstanceRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

#
# ECS Service Role
#
resource "aws_iam_role" "ecs_service_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsServiceRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

#
# ECS Container Service Task Role
#
resource "aws_iam_role" "ecs_tasks_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsTasksRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

#
# ECS Container Service Autoscaling Role
#
resource "aws_iam_role" "ecs_service_autoscaling_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsServiceAutoscalingRole"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "application-autoscaling.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


#
# Custom Policy - AmazonEC2ContainerServiceforEC2Role
#
resource "aws_iam_policy" "ec2_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceforEC2Role"
    description = "Custom Policy - Amazon EC2 Role for Amazon EC2 Container Service."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:CreateCluster",
                "ecs:DeregisterContainerInstance",
                "ecs:DiscoverPollEndpoint",
                "ecs:Poll",
                "ecs:RegisterContainerInstance",
                "ecs:StartTelemetrySession",
                "ecs:UpdateContainerInstancesState",
                "ecs:Submit*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonEC2ContainerServiceRole
#
resource "aws_iam_policy" "ecs_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceRole"
    description = "Custom Policy - Amazon ECS service role."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:Describe*",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:Describe*",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:RegisterTargets"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


#
# Custom Policy - AutoScalingFullAccess
#
resource "aws_iam_policy" "as_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AutoScalingFullAccess"
    description = "Custom Policy - Full access to Auto Scaling."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:PutMetricAlarm",
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonEC2ContainerServiceAutoscaleRole
#
resource "aws_iam_policy" "sas_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceAutoscaleRole"
    description = "Custom Policy - Enable Task Autoscaling for Amazon EC2 Container Service."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeServices",
                "ecs:UpdateService"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}


#
# Policy Attachments to AmazonEC2ContainerServiceforEC2Role
#
resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-ec2-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.name}"
    ]

    policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

#
# Policy Attachments to AmazonEC2ContainerServiceRole
#
resource "aws_iam_policy_attachment" "ecs_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-ecs-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_role.name}"
    ]

    policy_arn = "${aws_iam_policy.ecs_policy.arn}"
}

#
# Policy Attachments to AutoScalingFullAccess
#
resource "aws_iam_policy_attachment" "as_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-as-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_role.id}"
    ]

    policy_arn = "${aws_iam_policy.as_policy.arn}"
}

#
# Policy Attachments to AmazonEC2ContainerServiceAutoscaleRole
#
resource "aws_iam_policy_attachment" "sas_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-sas-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_autoscaling_role.id}"
    ]

    policy_arn = "${aws_iam_policy.sas_policy.arn}"
}


