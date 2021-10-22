variable "dynamodb" {
  type = list(map(any))
}

variable "db_attributes" {
  type    = list(map(any))
  default = [{}]
}
