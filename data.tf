data "aws_caller_identity" "current" {}

data "http" "argocd-deploykf-plugin" {
  url = "https://raw.githubusercontent.com/deployKF/deployKF/main/argocd-plugin/argocd-install/deploykf-plugin/plugin.yaml"
}

data "aws_route53_zone" "kubeflow" {
  count        = var.hosted_zone_id == null ? 0 : 1
  name         = "${var.hosted_zone_id}."
  private_zone = var.hosted_zone_private
}

data "aws_eks_cluster" "kubeflow" {
  count = var.eks_cluster_name == null ? 0 : 1
  name  = var.eks_cluster_name
}