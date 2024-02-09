
resource "aws_security_group" "ec2" {
  name = "sgec2test"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.sg_egress
  }

  tags = {
    Name = "sgec2test"
  }
}

resource "aws_security_group_rule" "ec2_to_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "TCP"
  security_group_id = "${aws_security_group.ec2.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  description       = "ec2-sg"
}

resource "aws_security_group_rule" "ec2_to_alb2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = "${aws_security_group.ec2.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  description       = "ec2-sg"
}

resource "aws_security_group_rule" "ec2_to_alb3" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  security_group_id = "${aws_security_group.ec2.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  description       = "ec2-sg"
}

resource "aws_security_group" "alb" {
  name = "sgalbtest"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.sg_egress
  }

  tags = {
    Name = "sgalbtest"
  }
}

resource "aws_security_group_rule" "alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = var.sg_egress
  security_group_id = "${aws_security_group.alb.id}"
  description       = "211021-221020_from_projectroom_private_to_aws-ss-vcms-alb-dev-an2-pri_HTTP_access"
}

resource "aws_security_group_rule" "alb_https" {
  type              = "ingress"
  from_port         = 433
  to_port           = 433
  protocol          = "TCP"
  cidr_blocks       = var.sg_egress
  security_group_id = "${aws_security_group.alb.id}"
  description       = "211021-221020_from_projectroom_private_to_aws-ss-vcms-alb-dev-an2-pri_HTTPS_access"
}