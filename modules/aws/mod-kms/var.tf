variable "kms_keys_alias" {
  type        = list(string)
  default     = [""]
  description = "names of all the kms keys"
}

variable "aws_key_role" {
  type        = list(string)
  default     = [""]
  description = "aws key role"
}

variable "kms_cloudwatch_alias" {
  type        = list(map(any))
  default     = [{}]
  description = "cloudwatch keys to encrypt data in cloudwatch. Need to add a policy to the key in order to configure the log group to encrypt the logs"
}
