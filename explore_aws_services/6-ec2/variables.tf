variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the Windows EC2 instance"
  default     = "t3.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  default     = "terraform-key"
}
#you can create in [ ec2/network & security/key ] 
variable "windows_key_name" {
  description = "The name of the SSH key pair for Windows instances"
  default     = "windows-rdp-key"
}
