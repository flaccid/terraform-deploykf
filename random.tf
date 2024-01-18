resource "random_string" "kubeflow_db_password" {
  length  = 32
  special = false
}
