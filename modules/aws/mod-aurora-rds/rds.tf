resource "aws_rds_cluster" "serverless" {
  count = length(var.aurora_rds_cluster)

  cluster_identifier      = "${lookup(var.aurora_rds_cluster[count.index], "websiteName")}-cluster"
  engine                  = lookup(var.aurora_rds_cluster[count.index], "engine")
  engine_version          = lookup(var.aurora_rds_cluster[count.index], "engine_version")
  engine_mode             = lookup(var.aurora_rds_cluster[count.index], "engine_mode")
  availability_zones      = lookup(var.aurora_networking[count.index], "subnet_az")
  database_name           = lookup(var.aurora_rds_cluster[count.index], "websiteName")
  master_username         = lookup(var.aurora_rds_cluster[count.index], "websiteName")
  master_password         = lookup(var.aurora_rds_cluster[count.index], "password")
  storage_encrypted       = lookup(var.aurora_rds_cluster[count.index], "serverless", false)
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name    = aws_db_subnet_group.serverless[count.index].id
  vpc_security_group_ids  = lookup(var.aurora_networking[count.index], "sg_id")
  enable_http_endpoint    = true
  deletion_protection     = true
  scaling_configuration {
    auto_pause   = lookup(var.aurora_rds_cluster[count.index], "production", false) == true ? false : true 
    min_capacity = lookup(var.aurora_rds_cluster[count.index], "min_scale", false)
    max_capacity = lookup(var.aurora_rds_cluster[count.index], "max_scale", false)
  }
}

resource "aws_db_subnet_group" "serverless" {
  count      = length(var.aurora_rds_cluster)

  name       = lookup(var.aurora_rds_cluster[count.index], "db_sg_name", "main_db_sg")
  subnet_ids = lookup(var.aurora_networking[count.index], "subnet_ids")

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster_parameter_group" "main" {
  count       = length(var.aurora_rds_cluster) 

  name        = "${lookup(var.aurora_rds_cluster[count.index], "websiteName")}-cluster-pg"
  family      = lookup(var.aurora_rds_cluster[count.index], "rds_family")
  description = "RDS default cluster parameter group"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}