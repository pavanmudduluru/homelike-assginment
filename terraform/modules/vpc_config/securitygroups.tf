resource "aws_security_group" "nginx" {
  name        = "nginx"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx"
  }
}

resource "aws_security_group" "alb" {
  name        = "alb"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb"
  }
}

resource "aws_security_group" "elb" {
  name        = "elb"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb"
  }
}

resource "aws_security_group" "nodejs" {
  name        = "nodejs"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nodejs"
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH inbound connections"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.206.32.92/32"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh"
  }
}

/*
resource "aws_security_group" "mongo_app" {
  vpc_id      = aws_vpc.vpc.id
  name        = "mongo_app"
  depends_on  = [aws_vpc.vpc]
  description = "Security group for apps that needs access to mongodb"

  tags = {
    Name        = "mongo_app"
  }
}

# MongoDB security group
resource "aws_security_group" "mongodb" {
  vpc_id      = aws_vpc.vpc.id
  name        = "mongodb"
  depends_on  = [aws_vpc.vpc]
  description = "Security group for mongodb"
  tags = {
    Name        = "mongodb"
  }
}

resource "aws_security_group_rule" "mongodb_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mongodb.id
}

# Allow all MongoDBs in the same security group communicate between each others
resource "aws_security_group_rule" "mongodb_mongodb" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mongodb.id
  security_group_id        = aws_security_group.mongodb.id
}

# Allow apps using mongodb connect to mongodb
resource "aws_security_group_rule" "mongo_app_mongodb" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mongo_app.id
  security_group_id        = aws_security_group.mongodb.id
}

# Allow all bastion hosts ssh to mongodbs
resource "aws_security_group_rule" "bastion_mongodb" {
  depends_on  = [aws_security_group.bastion]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.mongodb.id
}

# Allow all bastion hosts ping to mongodbs
resource "aws_security_group_rule" "bastion_ping_mongodb" {
  depends_on  = [aws_security_group.bastion]
  type                     = "ingress"
  from_port                = 8
  to_port                  = 0
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.mongodb.id
}

# Allow all bastion hosts connect to default mongodbs port for data access
resource "aws_security_group_rule" "bastion_dbconnect_mongodb" {
  depends_on  = [aws_security_group.bastion]
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.mongodb.id
}

resource "aws_security_group" "bastion" {
  vpc_id = "${aws_vpc.main.id}"
  name = "bastion"
  description = "Security group for bastion hosts"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion"
    Environment = "${var.environment}"
  }
}
*/