#
# Security Group for web Services
#
resource "aws_security_group" "web" {
    vpc_id = "${aws_vpc.default.id}"

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["10.213.0.0/16"]
    }

    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
	
    tags {
        Name = "${var.aws_env}-${var.aws_name}-sg-web"
    }

    name        = "${var.aws_env}-${var.aws_name}-sg-web"
    description = "${upper(var.aws_env)} - web Services Security Group"
}
