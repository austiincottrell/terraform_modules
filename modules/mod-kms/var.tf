variable "kms_keys_alias" {
  type        = list(string)
  description = "names of all the kms keys"
}

variable "aws_key_role" {
  type        = list(string)
  default     = [""]
  description = "aws key role"
}
