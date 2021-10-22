variable "cloudfront" {
  type        = list(map(any))
  description = "description"
}

variable "tags" {
  type        = map
  description = "tags to be added"
}

variable "aliases" {
  type        = list(map(any))
  description = "tags to be added"
}

variable "origin_access_identity" {
  type        = string
  description = "OAI for the cloudfront"
}