Example:

    module "secret-manager" {
    source       = "../../modules/mod-secrets-manager"
    websiteName  = var.websiteName
    kms_key      = data.terraform_remote_state.kms.outputs.key_arn[0]

    my_secret = [
        { "path" = "/prod/waf/id"}
    ]

    ### RDS Variables ###
    username           = var.rds_user
    rds_address        = "arn:aws:rds:${var.region}:${local.account_number}:cluster:${var.websiteName}-cluster"
    cluster_identifier = var.rds_id
    rds_pass           = [
        { "path" = "/prod/rds/${var.domainName}" }
    ]
    }