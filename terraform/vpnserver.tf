resource "aws_instance" "vpn_server" {
  ami = var.vpnserver_ami
  instance_type = var.vpnserver_instance_type
  subnet_id = module.vpc_config.public_subnets_id[0]
  security_groups = [aws_security_group.vpnserver.id]
  ebs_block_device {
    volume_size           = var.vpnserver_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = var.encrypt_vpnserver_volume
  }
  key_name = aws_key_pair.server_key.key_name
  tags = {
    Name = "vpnserver"
  }
}

locals {
  trusted_vpn = [
    "${aws_instance.vpn_server.public_ip}/32",
  ]
}