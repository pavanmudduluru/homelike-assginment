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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTnYZQtXdy76sDp6Y7lVjIXoFqt7KRkRZyVoUPfTlcpn+zqFXu8lC4njsCV4ChstVutQCvFOO6tVaA/RsHWxE9MsXmx5Nh3Y1nB+p2DzZi2foisxHvMhe0UiuZHfAUPeOoiMqTaYtKpidLX4BWODOLH3e42pulrbBCcPRBQxvsv3EH2Zz1OqMh/4U9g2UTeOY3gtguA+/q6Moms09fZhNH6Z65PquGdIY1j9g4TDHfm0dkh0fZmzgPnnBhlugzOr1wb6JaBk0axucmQxA/8/EedZ77N5Ga2UOj/jXqvlO+hVOg5LbyeodjYofBPmOqqftFDsSAxw5YIYE8DH93e8Rn server"
}