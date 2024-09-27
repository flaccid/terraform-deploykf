resource "random_string" "kubeflow_db_password" {
  count   = var.provision_rds_instance ? 1 : 0
  length  = 32
  special = false
}
