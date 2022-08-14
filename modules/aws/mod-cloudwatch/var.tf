variable "cloudalarm" {
  type        = list(map(any))
  default     = [{}]
  description = "Variable to call in multiple alarms for cloudwatch"
}

variable "log_group" {
  type        = list(map(any))
  default     = [{}]
  description = "Variable to call all your log group configuration (flow log name first)"
}

variable "flow_log" {
  type        = list(map(any))
  default     = [{}]
  description = "Variable to call in all your flow log vars (role arn, vpc id)"
}

variable "cloudwatch_kms_key" {
  type        = string
  description = "Cloudwatch kms key to encrypt data in the log groups"
}
