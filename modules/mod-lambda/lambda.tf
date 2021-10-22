resource "aws_lambda_function" "lambda" {
  count         = length(var.lambda_function)

  function_name = lookup(var.lambda_function[count.index], "name")
  role          = lookup(var.lambda_function[count.index], "role")

  timeout       = lookup(var.lambda_function[count.index], "timeout", null)
  filename      = lookup(var.lambda_function[count.index], "filename", null)
  handler       = lookup(var.lambda_function[count.index], "handler", null)
  memory_size   = lookup(var.lambda_function[count.index], "memory_size", null)
  runtime       = lookup(var.lambda_function[count.index], "runtime", null)
  kms_key_arn   = lookup(var.lambda_function[count.index], "kms_key",)
  source_code_hash = filebase64sha256(var.lambda_code_file[count.index])

  # only if we want vpc attached
  vpc_config      {
    security_group_ids = lookup(var.vpc_config[count.index], "sg", null)
    subnet_ids         = lookup(var.vpc_config[count.index], "sub_id", null)
  }

  environment     {
    variables = lookup(var.environment[count.index], "vars", null)
  }

  tags = {
    Name = lookup(var.lambda_function[count.index], "name")
    App  = lookup(var.lambda_function[count.index], "app_tag", null)
  }
}