module "deploy-kf" {
  source = "../"

  app_of_apps_values    = file("./app_of_apps_values.yaml")
  argocd_helm_values    = var.argocd_helm_values
  create_eks_cluster    = var.create_eks_cluster
  create_iam_resources  = var.create_iam_resources
  create_s3_buckets     = var.create_s3_buckets
  install_app_of_apps   = var.install_app_of_apps
  pipelines_bucket_name = var.pipelines_bucket_name
  subnet_ids            = var.subnet_ids
  vpc_id                = var.vpc_id
}
