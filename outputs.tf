output "vpc_id" {
  value = aws_vpc.iac-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.iac-public-subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.iac-private-subnet[*].id
}
