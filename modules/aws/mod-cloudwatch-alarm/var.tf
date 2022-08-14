variable "cloudalarm" {
  type        = list(map(any))
  default     = [{}]
  description = "Variable to call in multiple alarms for cloudwatch"
}

variable "dimensions" {
  type        = list(any)
  description = "The values you are pointing at"
}
