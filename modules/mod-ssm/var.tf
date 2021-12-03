variable "ssm_parameter" {
  type = list(map(any))
  description = "The parameter you would like to create"
}