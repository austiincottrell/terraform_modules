variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description about the VPC"
}

variable "network" {
  description = "dynamic network creation"
}

variable "subnets" {
  description = "dynamic subnets creation"
}

variable "secondary_ranges" {
  description = "dynamic secondary_ranges for subnets"
}