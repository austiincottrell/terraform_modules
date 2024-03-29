# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "network" {
  description = "dynamic network creation"
}

variable "subnets" {
  description = "dynamic subnets creation"
}

variable "secondary_ranges" {
  description = "dynamic secondary_ranges for subnets"
}

variable "firewall_rules" {
  description = "dynamic creation of firewall rules"
}

variable "routes" {
  description = "dynamic creation of network routes"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description about the VPC"
}

