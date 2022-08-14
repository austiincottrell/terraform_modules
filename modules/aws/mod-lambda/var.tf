variable "lambda_function" {
  type        = list(map(any))
  description = "var name = name of the function. var role is the role for the lambda function for it to assume. var vpc can equal anything as along as it has a vpc_conf variable correlating to it"
}

variable "vpc_config" {
  type        = list(map(any))
  default     = [{}]
  description = ""
}

variable "environment" {
  type        = list(map(any))
  default     = [{}]
  description = ""
}

variable "lambda_code_file" {
  type    = list(string)
  default = [""]
}

variable "event_function" {
  type        = list(map(any))
  description = "var name = name of the function. var role is the role for the lambda function for it to assume. var vpc can equal anything as along as it has a vpc_conf variable correlating to it"
}

variable "event_vpc_config" {
  type        = list(map(any))
  default     = [{}]
  description = ""
}

variable "event_environment" {
  type        = list(map(any))
  default     = [{"var" = null}]
  description = ""
}

variable "event_lambda_code_file" {
  type    = list(string)
  default = [""]
}