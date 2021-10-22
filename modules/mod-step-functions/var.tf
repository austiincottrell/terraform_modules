variable "step" {
  type        = list(map(any))
  description = "Main variable that will call in our step function variables from child module"
}
