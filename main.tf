provider "aws" {
  region = "ca-central-1"
}

resource "aws_vpc" "iac-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "iac-project-vpc"
  }
}

resource "aws_internet_gateway" "iac-igw" {
  vpc_id = aws_vpc.iac-vpc.id
  tags = {
    Name = "iac-project-igw"
  }
}

resource "aws_subnet" "iac-public-subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.iac-vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "iac-project-public-subnet-${count.index + 1}"
  }
}


resource "aws_route_table" "iac-public-rt" {
  vpc_id = aws_vpc.iac-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iac-igw.id
  }
  tags = {
    Name = "iac-project-public-rt"
  }
}

resource "aws_route_table_association" "iac-public-rt-assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.iac-public-subnet[count.index].id
  route_table_id = aws_route_table.iac-public-rt.id
}



resource "aws_subnet" "iac-private-subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.iac-vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "iac-project-private-subnet-${count.index + 1}"
  }
}