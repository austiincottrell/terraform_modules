variable "endpoint" {
  type        = list(map(any))
  description = "call multiple endpoints"
}

variable "cidr_block" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "section_cidr_block" {
  type = string
}

variable "subnet_name" {
  type    = map(string)
  default = {}
}

variable "public_subnets" {
    type    = map(bool)
    default = {}
}

variable "private_acl" {
  type    = list(any)
}

variable "db_acl" {
  type    = list(any)
}

variable "region" {
  type = string
}

variable "dns_support" {
  type    = bool
  default = true
}

variable "dns_hostnames" {
  type    = bool
  default = false
}

variable "private_subs" {
  type        = map(string)
  description = "names of private subnets"
}

variable "public_subs" {
  type        = map(string)
  description = "names of public subnets"
}

variable "name" {
  type    = string
  default = ""
}