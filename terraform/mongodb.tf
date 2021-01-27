resource "aws_instance" "db1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.mongodb_type
  key_name = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [ module.vpc_config.mongodb_sg,module.vpc_config.mongo_app_sg ]
  subnet_id = module.vpc_config.private_subnets_id[0]
  user_data = base64encode(file("user-data/mongodb-user-data.sh"))
  tags = {
    Name   = "DB1"
  }
}

resource "aws_eip" "eip_db1" {
  instance = aws_instance.db1.id
  vpc      = true
}

resource "aws_instance" "db2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.mongodb_type
  key_name = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [ module.vpc_config.mongodb_sg,vpc_config.mongo_app_sg ]
  user_data = base64encode(file("user-data/mongodb-user-data.sh"))
  subnet_id = module.vpc_config.private_subnets_id[2]
  tags = {
    Name   = "DB2"
  }
}

resource "aws_eip" "eip_db2" {
  instance = aws_instance.db2.id
  vpc      = true
}

resource "aws_instance" "db3" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.mongodb_type
  key_name = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [ module.vpc_config.mongodb_sg,vpc_config.mongo_app_sg ]
  user_data = base64encode(file("user-data/mongodb-user-data.sh"))
  subnet_id = module.vpc_config.private_subnets_id[2]
  tags = {
    Name   = "DB3"
  }
}

resource "aws_eip" "eip_db3" {
  instance = aws_instance.db3.id
  vpc      = true
}