variable "athena" {
  type        = list(map(any))
  description = "Create one database and one workgroup per module"
}

variable "query" {
  type        = list(map(any))
  default     = [{}]
  description = "Create as many different queries as needed"
}