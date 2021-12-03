variable "cloudfront" {
  type        = list(map(any))
  description = "All the variables you will passing in to create the CloudFront CDN"
}

variable "tags" {
  type        = map
  description = "tags to be added"
}

variable "aliases" {
  type        = list(map(any))
  description = "tags to be added"
}