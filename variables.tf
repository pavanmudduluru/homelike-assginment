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

#Nginx Configuration
variable "alb_name" {
  description = "Name of the ALB"
}

variable "target_group_name" {
  description = "Target Group Name"
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

#NodeJS Configuration
variable "elb_name" {
  description = "Name of the Classical LB"
}