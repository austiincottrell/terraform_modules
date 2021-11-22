variable "iam" {
  type        = list(map(any))
  description = "Main variable that will call in our iam variables from child module"
}

# variable "role" {
#   type        = list(map(any))
#   description = "side variable that will call in our iam variables from child module"
# }

variable "policy" {
  type        = list(map(any))
  description = "side variable that will call in our iam variables from child module"
}