variable "rds_allocated_storage" {
  type        = number
  default     = 20
  description = "Size in gigabytes to allocate to the rds instance"
}

variable "rds_instance_class" {
  default     = "db.t3.small"
  description = "Instance type for the rds instance"
}

variable "rds_name_prefix" {
  default     = "kubeflow-poc"
  description = "Prefix string to use for the RDS database name"
}

variable "rds_subnet_ids" {
  default     = []
  description = "VPC subnet IDs for the rds instance"
}

variable "rds_vpc_id" {
  default     = null
  description = "VPC ID for the rds instance"
}

variable "rds_auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Allow automated minor version upgrade"
}

variable "rds_allow_major_version_upgrade" {
  type        = bool
  default     = false
  description = "Allow major version upgrade"
}

variable "rds_apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
}

variable "rds_maintenance_window" {
  default     = "Mon:03:00-Mon:04:00"
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC"
}

variable "rds_skip_final_snapshot" {
  type        = bool
  default     = false
  description = "If true (default), no snapshot will be made before deleting DB"
}

variable "rds_copy_tags_to_snapshot" {
  type        = bool
  default     = true
  description = "Copy tags from DB to a snapshot"
}

variable "rds_backup_retention_period" {
  default     = 0
  description = "Backup retention period in days. Must be > 0 to enable backups"
}

variable "rds_backup_window" {
  default     = "22:00-03:00"
  description = "When AWS can perform DB snapshots, can't overlap with maintenance window"
}

variable "rds_kms_key_arn" {
  description = "The KMS Key ARN used for encryption with the storage"
  default     = null
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_engine_version" {
  default = "8.0.35"
}

variable "rds_major_engine_version" {
  default = "8.0"
}

variable "rds_database_port" {
  default = 3306
}

variable "rds_db_parameter_group" {
  default = "mysql8.0"
}
