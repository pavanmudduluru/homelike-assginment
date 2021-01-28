resource "aws_security_group" "nginx" {
  name        = "nginx"
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
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
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
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
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name = "elb"
  }
}

resource "aws_security_group" "nodejs" {
  name        = "nodejs"
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
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
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.local_ip}/32"]
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
  vpc_id = module.vpc_config.vpc_id
  depends_on  = [module.vpc_config.vpc]
  # allow all from Devops home
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.local_ip}/32"]
  }

  # allow 80 for letsencrypt (will be handled with firewalld)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow 443 for letsencrypt (will be handled with firewalld)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow 27017 from all members to all members
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = local.trusted_mongo
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [aws_security_group.nodejs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongodb"
  }
}