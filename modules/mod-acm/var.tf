variable "domains" {
  type    = string
  default = ""
}

variable "san" {
  type    = list
  default = []
}

variable my_tags {
  type = map
}