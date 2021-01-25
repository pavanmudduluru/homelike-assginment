aws_profile = "default"
aws_region = "eu-central-1"
vpc_cidr = "10.0.0.0/16"

alb_name = "nginx-alb"
target_group_name = "nginx-tg"
svc_port = 80
target_group_port = 80
target_group_path = "/"
alb_listener_port = 80
alb_listener_protocol = "HTTP"

elb_name = "nodejs-elb"