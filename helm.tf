resource "helm_release" "argo-cd" {
  count      = var.install_argocd ? 1 : 0
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version
  namespace  = var.argocd_namespace
  values     = [var.argocd_helm_values]

  depends_on = [
    kubernetes_namespace.argo-cd
  ]
}
