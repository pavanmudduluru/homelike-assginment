resource "aws_launch_configuration" "nginx_lc" {
  name = "${var.webserver}-lc"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [ module.vpc_config.nginx_sg, module.vpc_config.ssh_sg ]
  associate_public_ip_address = true
  key_name = aws_key_pair.server_key.key_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nginx_asg" {
  name = "${var.webserver}-asg"
  min_size             = 2
  max_size             = 2
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.nginx_lc.name
  vpc_zone_identifier = module.vpc_config.private_subnets_id
  target_group_arns = [aws_alb_target_group.nginx_target_group.arn]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "${var.webserver}-server"
    propagate_at_launch = true
  }

}

resource "aws_alb" "nginx_alb" {
  name = "${var.webserver}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ module.vpc_config.alb_sg ]
  subnets = module.vpc_config.public_subnets_id
  tags = {    
    Name = "${var.webserver}-alb" 
  }
}

resource "aws_alb_target_group" "nginx_target_group" {  
  name     = "${var.webserver}-tg"
  port     = var.svc_port
  protocol = "HTTP"  
  vpc_id   = module.vpc_config.vpc_id
  tags = {    
    Name = "${var.webserver}-tg"   
  }
  /*
  health_check {    
    healthy_threshold   = 5
    unhealthy_threshold = 2   
    timeout             = 5    
    interval            = 30   
    path                = var.target_group_path  
    port                = var.target_group_port 
  }
  */
}

resource "aws_alb_listener" "alb_listener" {  
  load_balancer_arn = aws_alb.nginx_alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol
  default_action {    
    target_group_arn = aws_alb_target_group.nginx_target_group.arn
    type             = "forward"  
  }
}