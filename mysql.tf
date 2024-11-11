# NOTE: WIP
# running sql statements directly due to chicken 'n' egg
# where a mysql terraform provider needs the database
# server to be available which is not the case if
# provisioning rds using this module (it doesn't exist yet)
# https://www.deploykf.org/guides/tools/external-mysql/#2-create-databases-and-user

# resource "null_resource" "init-mysql" {
#   count = var.create_databases ? 1 : 0

#   provisioner "local-exec" {
#     command = "psql -h host_name_here -p 5432 -U \"${var.kubeflow_database_user}\" -d \"${var.kubeflow_database_name}\" -f \"${path.module}/files/mysql-init.sql}\""

#     environment = {
#       PGPASSWORD = "${var.kubeflow_database_password}"
#     }
#   }
# }

# resource "mysql_database" "katib" {
#   count = var.create_databases ? 1 : 0

#   name = "katib"
# }

# resource "mysql_database" "kfp_cache" {
#   count = var.create_databases ? 1 : 0

#   name = "kfp_cache"
# }

# resource "mysql_database" "kfp_metadata" {
#   count = var.create_databases ? 1 : 0

#   name = "kfp_metadata"
# }

# resource "mysql_database" "kfp_pipelines" {
#   count = var.create_databases ? 1 : 0

#   name = "kfp_pipelines"
# }
