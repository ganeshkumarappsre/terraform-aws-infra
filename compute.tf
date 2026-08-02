data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "iac-ec2-instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.iac-key-pair.key_name
  subnet_id       = element(aws_subnet.iac-public-subnet[*].id, 0)
  vpc_security_group_ids = [aws_security_group.iac-ec2-sg.id]

  tags = {
    Name = "iac-project-ec2-instance"
  }
}