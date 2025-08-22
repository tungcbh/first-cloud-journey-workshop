variable "name" {
  description = "The name of the IAM group"
  type        = string
}

variable "path" {
  description = "The path for the IAM group"
  type        = string
  default     = "/"
}

variable "user_name" {
  description = "The name of the IAM user to add to the group"
  type        = string
}
