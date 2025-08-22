variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "subscriber_email_addresses" {
  description = "List of email addresses to receive budget notifications"
  type        = list(string)
  default     = ["email@example.com"]
}