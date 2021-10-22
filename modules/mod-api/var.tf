variable "api" {
  type        = list(map(any))
  description = "All the variables you will passing in to create the REST API Gateway"
}

variable "api_list" {
  type        = list(map(any))
  description = "How you want the api to interpret the data"
}
