Example:

module "rds" {
    source         = "../../modules/mod-aurora-rds"
    aurora_rds_cluster = [
        {
        production     = false
        serverless     = true
        min_scale      = 1
        max_scale      = 32
        db_sg_name     = var.rds_sg_name
        websiteName    = var.websiteName
        vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
        engine         = var.rds_engine  
        engine_version = var.rds_engine_version
        engine_mode    = var.rds_engine_mode
        rds_family     = var.rds_engine_family
        password       = data.terraform_remote_state.secrets-manager.outputs.secret_rds[0]
        }
    ]
    aurora_networking = [
        {
        sg_id      = [data.terraform_remote_state.sg.outputs.cidr_sg_id[0], data.terraform_remote_state.sg.outputs.sg_id[0]]
        subnet_ids = [data.terraform_remote_state.vpc.outputs.subnet_id[4], data.terraform_remote_state.vpc.outputs.subnet_id[5], data.terraform_remote_state.vpc.outputs.subnet_id[6]]
        subnet_az  = [data.terraform_remote_state.vpc.outputs.db_subnet_az[0], data.terraform_remote_state.vpc.outputs.db_subnet_az[1], data.terraform_remote_state.vpc.outputs.db_subnet_az[2]]
        }
    ]
}