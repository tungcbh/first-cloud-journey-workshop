variable "name" {
  description = "The name of the IAM user"
  type        = string
}

variable "path" {
  description = "The path for the IAM user"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to assign to the IAM user"
  type        = map(string)
  default     = {}
}
