variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the Windows EC2 instance"
  default     = "t3.micro"
}


variable "db_name" {
  description = "The name of the database to create"
  default     = "first_cloud_users"
}

variable "db_username" {
  description = "The username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "The password for the database"
  default     = "StrongPassword123!"
}
