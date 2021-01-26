resource "aws_launch_configuration" "nodejs_lc" {
  name = "${var.frontend}-lc"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [ module.vpc_config.nodejs_sg, module.vpc_config.ssh_sg ]
  associate_public_ip_address = true
  key_name = aws_key_pair.server_key.key_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nodejs_asg" {
  name = "${var.frontend}-asg"
  launch_configuration = aws_launch_configuration.nodejs_lc.name
  vpc_zone_identifier = module.vpc_config.private_subnets_id
  min_size = 2
  max_size = 3
  health_check_type = "ELB"
  load_balancers = [aws_elb.nodejs_elb.id]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "${var.frontend}-server"
    propagate_at_launch = true
  }
}

resource "aws_elb" "nodejs_elb" {
  name = "${var.frontend}-elb"
  internal = false
  security_groups = [ module.vpc_config.elb_sg ]
  subnets = module.vpc_config.public_subnets_id
  cross_zone_load_balancing = true
  /*
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2   
    timeout             = 5    
    interval            = 30 
    target = "HTTP:3000/"
  }
  */
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
  tags = {    
    Name = "${var.frontend}-elb" 
  }
}
