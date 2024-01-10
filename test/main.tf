module "deploy-kf" {
  source = "../"

  app_of_apps_values  = file("./app_of_apps_values.yaml")
  argocd_helm_values  = var.argocd_helm_values
  install_app_of_apps = var.install_app_of_apps
}
