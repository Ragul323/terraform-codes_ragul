resource "aws_vpc" "ragul" {
  cidr_block = var.vpc_cidr_ragul
  tags = {
    Name = "Ragul VPC"
  }
}
resource "aws_vpc" "navin" {
  cidr_block = var.vpc_cidr_navin
  tags = {
    Name = "Navin VPC"
  }
}
resource "aws_subnet" "ragul_subnet" {
  vpc_id     = aws_vpc.ragul.id
  cidr_block = var.subnet_cidr_ragul
}
resource "aws_subnet" "navin_subnet1" {
  vpc_id     = aws_vpc.navin.id
  cidr_block = var.subnet_cidr_navin
}
resource "aws_subnet" "navin_subnet2" {
  vpc_id     = aws_vpc.navin.id
  cidr_block = var.subnet_cidr2_navin
}
resource "aws_subnet" "navin_subnet3" {
  vpc_id     = aws_vpc.navin.id
  cidr_block = var.subnet_cidr3_navin
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ragul.id
}
resource "aws_route_table" "ragul_route_table" {
  vpc_id = aws_vpc.ragul.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
