output "vpc_id" {
  value = aws_vpc.iac-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.iac-public-subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.iac-private-subnet[*].id
}

output "ec2_instance_public_ip" {
  value = aws_instance.iac-ec2-instance.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.iac-rds-db-instance.endpoint
}