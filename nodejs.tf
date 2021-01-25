resource "aws_launch_configuration" "nodejs_lc" {
  name_prefix = "nodejs"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [ module.vpc_config.nodejs_sg ]
  #key_name = "${aws_key_pair.auth.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nodejs_asg" {
  name = "nodejs-asg"
  launch_configuration = aws_launch_configuration.nginx_lc.name
  vpc_zone_identifier = module.vpc_config.private_subnets_id
  min_size = 2
  max_size = 3
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "nodejs-server"
    propagate_at_launch = true
  }
}

resource "aws_elb" "nodejs_elb" {
  name = var.elb_name
  internal = false
  security_groups = [ module.vpc_config.elb_sg ]
  subnets = module.vpc_config.public_subnets_id
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 10
    timeout = 5
    interval = 10
    target = "HTTP:3000/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.nodejs_asg.id
  elb = aws_elb.nodejs_elb.id
}