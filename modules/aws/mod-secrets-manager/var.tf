variable "websiteName" {
  type        = string
  description = "name of the domain name without the .com, .io, .org"
}

variable "kms_key" {
  type = string
}

variable "username" {
  type = string
}

variable "rds_address" {
  type = string
}

variable "cluster_identifier" {
  type = string
}

variable "rds_pass" {
  type = list(map(any))
  default = [{}]
}

variable "my_secret" {
  type = list(map(any))
  default = [{}]
}