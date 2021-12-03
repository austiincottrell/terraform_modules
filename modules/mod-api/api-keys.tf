resource "aws_api_gateway_api_key" "cloud" {
  count = length(var.api)
  name  = lookup(var.api[count.index], "name")
}

resource "aws_api_gateway_usage_plan" "cloud" {
  count        = length(var.api)
  name         = lookup(var.api[count.index], "name")
  description  = "Usage plan for the api key"

  api_stages {
    api_id = aws_api_gateway_rest_api.api[count.index].id
    stage  = aws_api_gateway_stage.api[count.index].stage_name

    throttle {
    path        = "/${lookup(var.api[count.index], "path_part")}/${lookup(var.api[count.index], "http_method")}"
    burst_limit = 100
    rate_limit  = 1000
    }
  }

  quota_settings {
    limit  = 100000
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 5000
    rate_limit  = 10000
  }
}

resource "aws_api_gateway_usage_plan_key" "cloud" {
  count        = length(var.api)
  key_id        = aws_api_gateway_api_key.cloud[count.index].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.cloud[count.index].id
}