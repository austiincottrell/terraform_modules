variable "domain" {
  type        = string
  description = "All the variables you will passing in to create Route53 Records"
}

variable "record" {
  type = list(map(any))
}