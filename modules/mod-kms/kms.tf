resource "aws_kms_key" "key" {
  count               = length(var.kms_keys_alias) > 0 ? length(var.kms_keys_alias) : 0
  enable_key_rotation = true
}

resource "aws_kms_alias" "key" {
  count         = length(var.kms_keys_alias) > 0 ? length(var.kms_keys_alias) : 0
  name          = "alias/${element(var.kms_keys_alias, count.index)}"
  target_key_id = aws_kms_key.key[count.index].key_id
}

resource "aws_kms_key" "cloud" {
  count               = length(var.kms_cloudwatch_alias) > 0 ? length(var.kms_cloudwatch_alias) : 0
  enable_key_rotation = true
  policy              = <<EOF
{
 "Version": "2012-10-17",
    "Id": "cloudwatchkey",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${lookup(var.kms_cloudwatch_alias[count.index], "account_number")}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.${lookup(var.kms_cloudwatch_alias[count.index], "aws_region")}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${lookup(var.kms_cloudwatch_alias[count.index], "aws_region")}:${lookup(var.kms_cloudwatch_alias[count.index], "account_number")}:log-group:${lookup(var.kms_cloudwatch_alias[count.index], "log_group")}"
                }
            }
        }    
    ]
}
EOF
}

resource "aws_kms_alias" "cloud" {
  count         = length(var.kms_cloudwatch_alias) > 0 ? length(var.kms_cloudwatch_alias) : 0
  name          = "alias/${lookup(var.kms_cloudwatch_alias[count.index], "name")}"
  target_key_id = aws_kms_key.cloud[count.index].key_id
}
