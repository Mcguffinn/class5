resource "aws_lb" "coreCube_alb" {
  name               = "coreCube-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.coreCube-sg02-LB01.id]
  subnets            = [
    aws_subnet.public-ap-northeast-3a.id,
    aws_subnet.public-ap-northeast-3b.id,
    aws_subnet.public-ap-northeast-3c.id
  ]
  #Lots of death and suffering here, make sure it's false
  enable_deletion_protection = false

  tags = {
    Name    = "coreCubeLoadBalancer"
    Service = "coreCube"
    Owner   = "User"
    Project = "Web Service"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.coreCube_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.coreCube_tg.arn
  }
}
