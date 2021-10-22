variable "domain" {
  type        = string
  description = "description"
}

variable "record" {
  type = list(map(any))
}