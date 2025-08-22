variable "name" {
  type = string
}
variable "description" {
  type    = string
  default = ""
}
variable "policy" {
  type = string
}
variable "groups" {
  type    = list(string)
  default = []
}
variable "users" {
  type    = list(string)
  default = []
}
variable "roles" {
  type    = list(string)
  default = []
}
