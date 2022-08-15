# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "project id"
}

variable "gke" {
  description = "dynamic gke cluster creation"
}

variable "gke_sa" {
  description = "dynamic gke service account creation"
}

variable "gke_sa_roles" {
  description = "dynamic gke cluster service account roles permissions"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  type        = string
  default     = "Managed by Terraform"
}

variable "secrets_encryption_kms_key" {
  description = "The Cloud KMS key to use for the encryption of secrets in etcd, e.g: projects/my-project/locations/global/keyRings/my-ring/cryptoKeys/my-key"
  type        = string
  default     = null
}