data "aws_caller_identity" "current" {
  count = var.create_eks_cluster || var.create_iam_resources ? 1 : 0
}

data "http" "argocd-deploykf-plugin" {
  url = "https://raw.githubusercontent.com/deployKF/deployKF/main/argocd-plugin/argocd-install/deploykf-plugin/plugin.yaml"
}

data "aws_route53_zone" "kubeflow" {
  count        = var.hosted_zone_id == null ? 0 : 1
  name         = "${var.hosted_zone_id}."
  private_zone = var.hosted_zone_private
}

data "aws_eks_cluster" "kubeflow" {
  count = var.existing_eks_cluster ? 1 : 0
  name  = var.cluster_name
}
