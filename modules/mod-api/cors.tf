resource "aws_api_gateway_method" "cors" {
  count = length(var.api)

  rest_api_id   = aws_api_gateway_rest_api.api[count.index].id
  resource_id   = aws_api_gateway_resource.api[count.index].id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cors" {
  count = length(var.api)
  
  rest_api_id             = aws_api_gateway_rest_api.api[count.index].id
  resource_id             = aws_api_gateway_resource.api[count.index].id
  http_method             = aws_api_gateway_method.cors[count.index].http_method
  passthrough_behavior    = lookup(var.api[count.index], "passthrough_behavior")
  type                    = "MOCK"
  request_templates       = {
    "application/json" = <<EOF
{"statusCode": 200}
EOF
  }
}

resource "aws_api_gateway_integration_response" "cors" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id
  resource_id = aws_api_gateway_resource.api[count.index].id
  http_method = aws_api_gateway_method.cors[count.index].http_method
  status_code = aws_api_gateway_method_response.cors[count.index].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'${lookup(var.api[count.index], "name")}'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,${aws_api_gateway_method.api[count.index].http_method}'"
  }

  response_templates = {
    lookup(var.api[count.index], "content_type") = ""
  }
}

resource "aws_api_gateway_method_response" "cors" {
  count = length(var.api)

  rest_api_id = aws_api_gateway_rest_api.api[count.index].id
  resource_id = aws_api_gateway_resource.api[count.index].id
  http_method = aws_api_gateway_method.cors[count.index].http_method
  status_code = "200"

  response_parameters = { 
    "method.response.header.Access-Control-Allow-Origin" = false,
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
  }
}