Example:

    module "ssm" {
    source = "../../modules/mod-ssm"
    ssm_parameter = [
        {
        name  = var.ssm_cloudtrail_query_name
        type  = "String"
        value = "temp"
        tier  = "Standard"
        description = "Cloudtrail athena query id"
        }
    ]
    }
