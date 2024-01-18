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
