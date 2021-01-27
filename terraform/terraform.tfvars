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
nginx_instance_type = "t2.micro"
nodejs_instance_type = "t2.micro"

#### Local IP #######
local_ip = "49.206.32.92"

##### MongoDB Details ######
mongo_ami = "ami-096b8af6e7e8fb927"
mongo_instance_type = "t3a.medium"
mongo_arbiter_instance_type = "t3a.medium"
mongo_volume_size = 30
mongo_arbiter_volume_size = 30
encrypt_mongo_volume = "false"