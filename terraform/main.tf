module "vpc_config" {
  source = "./modules/vpc_config"
  aws_region = var.aws_region
  vpc_cidr = var.vpc_cidr
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_key_pair" "server_key" {
  key_name   = var.key_name
  public_key = file("${var.public_key_path}")
}