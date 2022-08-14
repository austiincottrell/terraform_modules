variable "topic" {
  type = list(map(any))
}

variable "subs" {
  type    = list(map(any))
  default = [{}]
}