provider "aws" {
  region = var.region
}
resource "aws_instance" "ragul_instance" {
  ami           = "ami-0522ab6e1ddcc7055"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.ragul_subnet.id
  depends_on    = [aws_vpc.ragul.id] 
  tags = {
    Name = "Ragul EC2 Instance"
  }
}