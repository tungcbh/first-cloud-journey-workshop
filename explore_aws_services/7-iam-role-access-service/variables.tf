variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the Windows EC2 instance"
  default     = "t3.micro"
}