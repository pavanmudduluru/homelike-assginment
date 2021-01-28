resource "aws_instance" "mongodb_1" {
  ami = var.mongo_ami
  instance_type = var.mongo_instance_type
  subnet_id = module.vpc_config.private_subnets_id[0]
  security_groups = [aws_security_group.mongodb.id]
  ebs_block_device {
    volume_size           = var.mongo_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = var.encrypt_mongo_volume
  }
  key_name = aws_key_pair.server_key.key_name
  tags = {
    Name = "mongo-1"
  }
}

resource "aws_instance" "mongodb_2" {
  ami = var.mongo_ami
  instance_type = var.mongo_instance_type
  subnet_id = module.vpc_config.private_subnets_id[1]
  security_groups = [aws_security_group.mongodb.id]
  ebs_block_device {
    volume_size           = var.mongo_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = var.encrypt_mongo_volume
  }
  key_name = aws_key_pair.server_key.key_name
  tags = {
    Name = "mongo-2"
  }
}

resource "aws_instance" "mongodb_3" {
  ami = var.mongo_ami
  instance_type = var.mongo_instance_type
  subnet_id = module.vpc_config.private_subnets_id[2]
  security_groups = [aws_security_group.mongodb.id]
  ebs_block_device {
    volume_size           = var.mongo_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = var.encrypt_mongo_volume
  }
  key_name = aws_key_pair.server_key.key_name
  tags = {
    Name = "mongo-3"
  }
}

resource "aws_eip" "mongo_1" {
}

resource "aws_eip" "mongo_2" {
}

resource "aws_eip" "mongo_3" {
}

locals {
  trusted_mongo = [
    "${aws_eip.mongo_1.public_ip}/32", 
    "${aws_eip.mongo_2.public_ip}/32",
    "${aws_eip.mongo_3.public_ip}/32",
  ]
}

resource "aws_eip_association" "eip_assoc_mongo_1" {
  instance_id   = aws_instance.mongodb_1.id
  allocation_id = aws_eip.mongo_1.id
}

resource "aws_eip_association" "eip_assoc_mongo_2" {
  instance_id   = aws_instance.mongodb_2.id
  allocation_id = aws_eip.mongo_2.id
}

resource "aws_eip_association" "eip_assoc_mongo_3" {
  instance_id   = aws_instance.mongodb_3.id
  allocation_id = aws_eip.mongo_3.id
}