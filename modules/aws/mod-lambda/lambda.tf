resource "aws_lambda_function" "lambda" {
  count         = length(var.lambda_function) > 0 ? length(var.lambda_function) : 0

  function_name = lookup(var.lambda_function[count.index], "name")
  role          = lookup(var.lambda_function[count.index], "role")

  timeout       = lookup(var.lambda_function[count.index], "timeout", null)
  filename      = lookup(var.lambda_function[count.index], "filename", null)
  handler       = lookup(var.lambda_function[count.index], "handler", null)
  memory_size   = lookup(var.lambda_function[count.index], "memory_size", null)
  runtime       = lookup(var.lambda_function[count.index], "runtime", null)
  kms_key_arn   = lookup(var.lambda_function[count.index], "kms_key",)
  source_code_hash = filebase64sha256(var.lambda_code_file[count.index])
  layers           = [lookup(var.lambda_function[count.index], "layers")]

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

resource "aws_iam_role_policy_attachment" "lambda" {
  count      = length(var.lambda_function) > 0 ? length(var.lambda_function) : 0
  role       = lookup(var.lambda_function[count.index], "role_name")
  policy_arn = lookup(var.lambda_function[count.index], "iam_policies")
}

####################################
### Event Driven Lambda Function ###
####################################

resource "aws_cloudwatch_event_rule" "event" {
  count               = length(var.event_function) > 1 ? length(var.event_function) : 0
  name                = lookup(var.event_function[count.index], "name", null)
  event_pattern       = lookup(var.event_function[count.index], "event_pattern", null)
  schedule_expression = lookup(var.event_function[count.index], "schedule_expression", null)
}

resource "aws_cloudwatch_event_target" "event" {
  count = length(var.event_function) > 1 ? length(var.event_function) : 0
  arn   = aws_lambda_function.event[count.index].arn
  rule  = aws_cloudwatch_event_rule.event[count.index].name
}

resource "aws_lambda_permission" "event" {
  count         = length(var.event_function) > 1 ? length(var.event_function) : 0
  source_arn    = aws_cloudwatch_event_rule.event[count.index].arn
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.event[count.index].function_name
  principal     = "events.amazonaws.com"
  statement_id  = "DeployLambda"
}

resource "aws_lambda_function" "event" {
  count         = length(var.event_function) > 1 ? length(var.event_function) : 0

  function_name = lookup(var.event_function[count.index], "name", null)
  role          = lookup(var.event_function[count.index], "role", null)

  timeout          = lookup(var.event_function[count.index], "timeout", null)
  filename         = lookup(var.event_function[count.index], "filename")
  handler          = lookup(var.event_function[count.index], "handler", null)
  memory_size      = lookup(var.event_function[count.index], "memory_size", null)
  runtime          = lookup(var.event_function[count.index], "runtime", null)
  kms_key_arn      = lookup(var.event_function[count.index], "kms_key", null)
  source_code_hash = length(filebase64sha256(var.event_lambda_code_file[count.index])) > 0 ? filebase64sha256(var.event_lambda_code_file[count.index]) : null

  # only if we want vpc attached
  vpc_config      {
    security_group_ids = lookup(var.event_vpc_config[count.index], "sg", null)
    subnet_ids         = lookup(var.event_vpc_config[count.index], "sub_id", null)
  }

  environment     {
    variables = lookup(var.event_environment[count.index], "vars", null)
  }

  tags = {
    Name = lookup(var.event_function[count.index], "name", null)
    App  = lookup(var.event_function[count.index], "app_tag", null)
  }
}

resource "aws_iam_role_policy_attachment" "event" {
  count      = length(var.event_function) > 1 ? length(var.event_function) : 0
  role       = lookup(var.event_function[count.index], "role_name")
  policy_arn = lookup(var.event_function[count.index], "iam_policies")
}