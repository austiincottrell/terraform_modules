variable "step" {
  type        = list(map(any))
  description = "Main variable that will call in our step function variables from child module"
}

variable "logging" {
  type        = list(map(any))
  description = "Logging configuration"
}

variable "event_step" {
  type        = list(map(any))
  default     = [{}]
  description = "Main variable that will call in our step function variables from child module"
}
