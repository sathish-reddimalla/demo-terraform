#
# Private Subsets
#
resource "aws_subnet" "us-east-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block        = "10.213.1.0/24"
    availability_zone = "us-east-1a"

    tags {
        Name = "${var.aws_name}-sn-private-1a"
    }
}

resource "aws_subnet" "us-east-1b-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block        = "10.213.2.0/24"
    availability_zone = "us-east-1b"

    tags {
        Name = "${var.aws_name}-sn-private-1b"
    }
}

#
# Routing Table for Private Subnets

resource "aws_route_table" "us-east-1-private" {
    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.aws_name}-rt-private"
    }
}

#
# Routing Table Association for Private Subnets
#
resource "aws_route_table_association" "us-east-1a-private" {
    subnet_id      = "${aws_subnet.us-east-1a-private.id}"
    route_table_id = "${aws_route_table.us-east-1-private.id}"
}
resource "aws_route_table_association" "us-east-1b-private" {
    subnet_id      = "${aws_subnet.us-east-1b-private.id}"
    route_table_id = "${aws_route_table.us-east-1-private.id}"
}

##################################################################################

#
# Public Subsets
#
resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block        = "10.213.3.0/24"
    availability_zone = "us-east-1a"

    tags {
        Name = "${var.aws_name}-sn-public-1a"
    }
}

resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block        = "10.213.4.0/24"
    availability_zone = "us-east-1b"

    tags {
        Name = "${var.aws_name}-sn-public-1b"
    }
}

#
# Routing Table for Public Subnets

resource "aws_route_table" "us-east-1-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        #nat_gateway_id = "${aws_nat_gateway.ngw.id}"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "${var.aws_name}-rt-public"
    }
}

#
# Routing Table Association for Public Subnets
#
resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id      = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1-public.id}"
}
resource "aws_route_table_association" "us-east-1b-public" {
    subnet_id      = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-1-public.id}"
}