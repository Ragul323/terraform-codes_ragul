resource "aws_db_instance" "navin_rds" {
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  allocated_storage    = 20
  db_name              = "mydb"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.navin_subnet_group.name
}
resource "aws_db_subnet_group" "navin_subnet_group" {
  name       = "navin_subnet_group"
  subnet_ids = [aws_subnet.navin_subnet1.id, aws_subnet.navin_subnet2.id, aws_subnet.navin_subnet3.id]
  depends_on = [aws_vpc.navin]
  tags = {
    Name = "Navin RDS Subnet Group"
  }
}
output "rds_instance_id" {
  value = aws_db_instance.navin_rds.id
}
