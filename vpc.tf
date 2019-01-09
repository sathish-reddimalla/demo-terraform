#
# Primary VPC
#
resource "aws_vpc" "default" {
    cidr_block           = "10.213.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags {
        Name = "${var.aws_env}-${var.aws_name}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.aws_name}-internet-gateway"
    }
}