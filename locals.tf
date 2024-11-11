locals {
  eks_oidc_issuer         = var.existing_eks_cluster ? replace(data.aws_eks_cluster.kubeflow[0].identity[0].oidc[0].issuer, "https://", "") : ""
  mysql_database_password = length(var.kubeflow_database_password) > 0 ? var.kubeflow_database_password : try(random_string.kubeflow_db_password[0].result, "")
  mysql_host              = var.provision_rds_instance ? module.kubeflow-mysql-instance.instance_address : var.mysql_host
  iam_role_arn            = var.kubeflow_iam_role_arn != null ? var.kubeflow_iam_role_arn : var.create_iam_resources ? try(aws_iam_role.kubeflow[0].arn, "") : ""
  repo_server_patch       = templatefile("${path.module}/files/argocd-repo-server-patch.yaml", { "name" = var.argocd_deployment_name })
}
