variable "region" {
  type        = string
}
variable "iam_users" {
  type        = list(string)
}
variable "vpc_cidr_ragul" {
  type        = string
}
variable "vpc_cidr_navin" {
  type        = string
}
variable "subnet_cidr_ragul" {
  type        = string
}
variable "subnet_cidr_navin" {
  type        = string
}
variable "instance_type" {
  type        = string
}
variable "db_instance_class" {
  type        = string
}
variable "db_engine" {
  type        = string
}
variable "db_username" {
  type        = string
}
variable "db_password" {
  type        = string
}
variable "worker_instance_type" {
  type        = string
}
variable "key_name" {
  type        = string
}
variable "cluster_name" {
  default = "my-msk-cluster"
}
variable "broker_instance_type" {
  default = "kafka.m5.large"
}
variable "num_brokers" {
  default = 3
}
variable "kafka_version" {
  default = "2.6.1"
}
variable "security_group_ids" {
  default = "sg-0b058e21c6fde00ce"
}


------------------
variable "rds_instance_id" {
  description = "The ID of the RDS instance to start or stop"
  type        = string
}
