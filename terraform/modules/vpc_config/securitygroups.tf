/*resource "aws_security_group" "default" {
  name        = "default"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  } 
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Name = "default"
  }
}
*/

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

resource "aws_security_group" "mongodb" {
  name        = "mongodb"
  vpc_id = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    self = true
    cidr_blocks = ["49.206.32.92/32"]
    #security_groups = [aws_security_group.mongodb.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mongodb"
  }
}