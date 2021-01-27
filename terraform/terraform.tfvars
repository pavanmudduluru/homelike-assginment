aws_profile = "default"
aws_region = "eu-central-1"
vpc_cidr = "10.0.0.0/16"

frontend = "nodejs"
webserver = "nginx"

#### ALB Details ######
svc_port = 80
target_group_port = 80
target_group_path = "/"
alb_listener_port = 80
alb_listener_protocol = "HTTP"

#### Key Pair Name #####
key_name = "server"

#### Instance Types #####
nginx_type = "t2.micro"
nodejs_type = "t2.micro"
mongodb_type = "t2.nano"