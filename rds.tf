module "kubeflow-mysql-instance" {
  count   = var.provision_rds_instance ? 1 : 0
  source  = "cloudposse/rds/aws"
  version = "1.1.0"

  name                 = var.rds_name_prefix
  vpc_id               = var.rds_vpc_id
  subnet_ids           = var.rds_subnet_ids
  instance_class       = var.rds_instance_class
  allocated_storage    = var.rds_allocated_storage
  kms_key_arn          = var.rds_kms_key_arn
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  major_engine_version = var.rds_major_engine_version
  database_port        = var.rds_database_port
  db_parameter_group   = var.rds_db_parameter_group

  database_name     = var.kubeflow_database_name
  database_user     = var.kubeflow_database_user
  database_password = local.mysql_database_password

  auto_minor_version_upgrade  = var.rds_auto_minor_version_upgrade
  allow_major_version_upgrade = var.rds_allow_major_version_upgrade
  apply_immediately           = var.rds_apply_immediately
  maintenance_window          = var.rds_maintenance_window
  skip_final_snapshot         = var.rds_skip_final_snapshot
  copy_tags_to_snapshot       = var.rds_copy_tags_to_snapshot
  backup_retention_period     = var.rds_backup_retention_period
  backup_window               = var.rds_backup_window

  allowed_cidr_blocks = ["10.0.0.0/8"]
}
