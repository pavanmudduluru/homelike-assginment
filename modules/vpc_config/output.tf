output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnet.*.id
}

/*
output "default_sg" {
  value = aws_security_group.default.id
}
*/

output "nginx_sg" {
  value = aws_security_group.nginx.id
}

output "nodejs_sg" {
  value = aws_security_group.nodejs.id
}

output "alb_sg" {
  value = aws_security_group.alb.id
}

output "elb_sg" {
  value = aws_security_group.elb.id
}

output "ssh_sg" {
  value = aws_security_group.ssh.id
}

output "mongodb_sg" {
  value = aws_security_group.mongodb.id
}