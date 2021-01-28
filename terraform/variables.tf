variable "aws_region" {
  description = "eu-central-1"
}

variable "aws_profile" {
  description = "Defaut"
}

variable "nginx_instance_type" {
  description = "Nginx Instance type"
}

variable "nodejs_instance_type" {
  description = "nodejs Instance type"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_key_path" {
  description = "The path of the public key file to use"
  default     = "/home/pavan/.ssh/id_rsa.pub"
}

variable "key_name" {
  description = "Name of the Key for servers"
}

#Nginx Configuration
variable "frontend" {
  description = "Name of the frontend service"
}

variable "webserver" {
  description = "Nginx"
}

variable "svc_port" {
  description = "Target Group service port"
}

variable "target_group_port" {
  description = "Health check port"
}

variable "target_group_path" {
  description = "health check path"
}

variable "alb_listener_port" {
  description = "Listener port"
}

variable "alb_listener_protocol" {
  description = "Listener protocol"
}

variable "local_ip" {
  description = "Local Machine IP"
}

variable "mongo_ami" {
  description = "Using Ubuntu 18.04"
}

variable "mongo_instance_type" {
  description = "Type of instance to use for mongodb nodes"
}

variable "mongo_volume_size" {
  description = "Size in GB of the mongodb volume"
}

variable "encrypt_mongo_volume" {
  description = "Define whereas the mongodb volume needs to be encrypted"
}

variable "vpnserver_ami" {
  description = "Using Oracle linux"
}

variable "vpnserver_instance_type" {
  description = "Type of instance to use for vpnserver"
}

variable "vpnserver_volume_size" {
  description = "Size in GB of the vpnserver volume"
}

variable "encrypt_vpnserver_volume" {
  description = "Enabling encryption"
}