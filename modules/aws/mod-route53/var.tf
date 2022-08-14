variable "domain" {
  type        = string
  description = "Domain name of the public hosted zone that you have registered through Route53"
}

variable "record" {
  type = list(map(any))
}