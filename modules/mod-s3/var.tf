variable "s3_bucket" {
  type    = list(map(any))
  default = [{}]
}

variable "website" {
  type    = list(map(any))
  default = [{}]
}

variable "logging" {
  type    = list(map(any))
  default = [{}]

}

variable "lifecycle_rule" {
  type    = list(map(any))
  default = [{}]
}

variable "website_lifecycle_rule" {
  type    = list(map(any))
  default = [{}]
}

variable "logging_lifecycle_rule" {
  type    = list(map(any))
  default = [{}]
}

variable "kms_encrypt" {
  type    = bool
  default = false
}

variable "logging_bucket" {
  type    = string
  default = ""
}