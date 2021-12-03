  resource "aws_api_gateway_rest_api" "api" {
  count = length(var.api)

  name           = lookup(var.api[count.index], "name")
  description    = lookup(var.api[count.index], "description", null)
  api_key_source = lookup(var.api[count.index], "key_source", "Header")

  binary_media_types = lookup(var.api_list[count.index], "binary_media_types")

  endpoint_configuration {
    types            = [lookup(var.api[count.index], "types")]
    # vpc_endpoint_ids = [lookup(var.api[count.index], "vpc_endpoint_ids", null)]
  }
}

resource "aws_api_gateway_model" "api" {
  count        = length(var.api)
  rest_api_id  = aws_api_gateway_rest_api.api[count.index].id
  name         = lookup(var.api[count.index], "model_name")
  content_type = lookup(var.api[count.index], "content_type", "application/json")

  schema = lookup(var.api[count.index], "model_schema")
}

resource "aws_api_gateway_resource" "api" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id
  parent_id   = aws_api_gateway_rest_api.api[count.index].root_resource_id
  path_part   = lookup(var.api[count.index], "path_part")
}

resource "aws_api_gateway_request_validator" "api" {
  count                       = length(var.api)
  name                        = lookup(var.api[count.index], "name")
  rest_api_id                 = aws_api_gateway_rest_api.api[count.index].id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_method" "api" {
  count = length(var.api)
  depends_on    = [aws_api_gateway_model.api]

  rest_api_id          = aws_api_gateway_rest_api.api[count.index].id
  resource_id          = aws_api_gateway_resource.api[count.index].id
  http_method          = lookup(var.api[count.index], "http_method")
  authorization        = lookup(var.api[count.index], "authorization", null)
  api_key_required     = lookup(var.api[count.index], "api_key", null)
  request_validator_id = aws_api_gateway_request_validator.api[count.index].id

  request_parameters = {
    "method.request.header.Content-type" = false,
    "method.request.header.X-Api-Key"    = false
  }

  request_models = {
      lookup(var.api[count.index], "content_type", "application/json") = lookup(var.api[count.index], "model_name")
    }
}

resource "aws_api_gateway_integration" "api" {
  count = length(var.api)
  
  rest_api_id             = aws_api_gateway_rest_api.api[count.index].id
  resource_id             = aws_api_gateway_resource.api[count.index].id
  http_method             = aws_api_gateway_method.api[count.index].http_method
  integration_http_method = lookup(var.api[count.index], "integration_http_method")
  type                    = lookup(var.api[count.index], "type")
  uri                     = lookup(var.api[count.index], "uri")
  passthrough_behavior    = lookup(var.api[count.index], "passthrough_behavior")
  request_templates       = {
    lookup(var.api[count.index], "content_type", "application/json") = lookup(var.api[count.index], "mapping_template")
  }
}

resource "aws_api_gateway_integration_response" "api" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id
  resource_id = aws_api_gateway_resource.api[count.index].id
  http_method = aws_api_gateway_method.api[count.index].http_method
  status_code = aws_api_gateway_method_response.api[count.index].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    lookup(var.api[count.index], "content_type") = ""
  }
}

resource "aws_api_gateway_method_response" "api" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id
  resource_id = aws_api_gateway_resource.api[count.index].id
  http_method = aws_api_gateway_method.api[count.index].http_method
  status_code = "200"

  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = false }
}

resource "aws_api_gateway_deployment" "api" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api[count.index].id,
      aws_api_gateway_method.api[count.index].id,
      aws_api_gateway_integration.api[count.index].id,
    ])) }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api" {
  count = length(var.api)

  deployment_id = aws_api_gateway_deployment.api[count.index].id
  rest_api_id   = aws_api_gateway_rest_api.api[count.index].id
  stage_name    = lookup(var.api[count.index], "stage")
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  count = length(var.api)

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = lookup(var.api[count.index], "lambda_name")
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${lookup(var.api[count.index], "region")}:${lookup(var.api[count.index], "account_number")}:${aws_api_gateway_rest_api.api[count.index].id}/*/${aws_api_gateway_method.api[count.index].http_method}${aws_api_gateway_resource.api[count.index].path}"
}