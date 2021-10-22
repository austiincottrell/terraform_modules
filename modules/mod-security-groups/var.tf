variable "security_group" {
  type        = list(string)
  description = "what will be called in the main.tf"
}

variable "sg" {
  type        = list(map(any))
  description = "call the ingress and egress values"
}

variable "vpc_id" {
  type        = string
  description = "the id of the vpc"
}
