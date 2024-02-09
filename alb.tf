#### alb ####
resource "aws_lb" "alb" {
  name               = "alb-test"
  load_balancer_type = "application"
  internal           = false
  subnets            = aws_subnet.public.*.id
  security_groups = [
    aws_security_group.alb.id
  ]
  depends_on = [aws_instance.this]
  tags = {
    Name = "alb-pub-test"
  }
  timeouts {
    create = "30m"
    delete = "30m"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_lb_target_group" "target" {
  name        = "alb-web-tg1"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "alb-web-tg-1"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.target.arn
  target_id        = aws_instance.this.id
  port             = "80"
}

resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}