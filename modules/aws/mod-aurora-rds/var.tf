variable "aurora_rds_cluster" {
  type        = list(map(any))
  description = "All the variables you will passing in to create the Aurora RDS"
}

variable "aurora_networking" {
  type        = list(map(any))
  description = "The networking variables to be passed to the Aurora RDS"
}
