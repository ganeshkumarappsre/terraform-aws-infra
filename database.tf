resource "aws_db_subnet_group" "iac-rds-db-private-subnet-group" {
  subnet_ids = [aws_subnet.iac-private-subnet[0].id, aws_subnet.iac-private-subnet[1].id]

  tags = {
    Name = "iac-rds-db-private_subnet-group"
  }
}

resource "aws_security_group" "iac-rds-db-sg" {
  description = "Allow traffic only from EC2 Security Group"
  vpc_id      = aws_vpc.iac-vpc.id

  ingress {
    description     = "Allow MySQL traffic from EC2 Security Group"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.iac-ec2-sg.id]
  }

  egress {

    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "iac-rds-db-sg"
  }
}


resource "aws_db_instance" "iac-rds-db-instance" {
  identifier             = "iac-rds-db-instance"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "iacprojectdb"
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.iac-rds-db-private-subnet-group.name
  vpc_security_group_ids = [aws_security_group.iac-rds-db-sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  storage_type           = "gp2"
  multi_az               = false

  tags = {
    Name = "iac-rds-db-instance"
  }
}