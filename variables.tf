variable "aws_region" {
  description = "eu-central-1"
}

variable "aws_profile" {
  description = "Defaut"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
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
