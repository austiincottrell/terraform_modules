variable "domain" {
  type        = string
  default     = ""
  description = "The domain name you want to attach to Route53"
}

variable "fqdn" {
  type        = string
  default     = ""
  description = "The public domain name of the Route53 website name you registered"
}

variable "san" {
  type        = list
  default     = []
  description = "The subject alternative names of the Route53 website name you registered"
}

variable my_tags {
  type = map
}