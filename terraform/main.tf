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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFp3uDohl3M5XQO5Pntrupf4HF6jawg9n1vzen3wqCqKGHd6bs0R2gJBF14wdwf6/s6ncJH2YJ5oLTl2v3qNMMynR9SL432jvISxXueh+Miq/g52HVqcbpeUSTLki9twH2O6vyPojNCcMSfawlIToRyjaZM1WRwsHVzF/J+MlSoOJ7rMrq1qSTF0P4WFEEW3/rIwl45UYdsfl/AKI4XB3SkgGZadfuxVqy9LtMoRj2cZDlOvE4Q6LwSTVLHQFWTb+mQuoPmaZvz8zCS8ySqDoORDtlZeVn6s7xH10y6u69Wb7mUBWuzHeDHsNHZThR0DHj1T///2qTOYJregMX8df8dZ7zqQd6p6vG889qMBkxEQ3m8bQmt4nCM7qnXescv/rZxPegK9DZlfjBI4geu9XhSbczj5doQDlGuKgO/hsAAQHYqnm+Dt8gxB29lPtc99Mk/J8ttG++SmFCd4hl1gyt/VF/sByeVhhN6DUyi1xCbQlTkjEBj0RkglPD0cAIdT8= server"
}