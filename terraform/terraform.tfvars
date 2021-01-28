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

#### Key Pair Details #####
public_key_path = "<key_path>"
key_name = "server"

#### Instance Types #####
nginx_instance_type = "t2.micro"
nodejs_instance_type = "t2.micro"

#### Local IP #######
local_ip = "<local_machine_ip>"

##### MongoDB Details ######
mongo_ami = "ami-0b418580298265d5c"
mongo_instance_type = "t2.medium"
mongo_volume_size = 30
encrypt_mongo_volume = "true"

##### VPN Server #######
vpnserver_ami = "ami-0a574c907cab224f9"
vpnserver_instance_type = "t2.micro"
vpnserver_volume_size = 10
encrypt_vpnserver_volume = "true"