resource "kubernetes_namespace" "argo-cd" {
  count = var.create_argocd_namespace ? 1 : 0

  metadata {
    name = var.argocd_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}

resource "kubernetes_namespace" "deploykf-auth" {
  count = var.create_deploykf_auth_namespace ? 1 : 0

  metadata {
    name = "deploykf-auth"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}

resource "kubernetes_namespace" "kubeflow" {
  count = var.create_kubeflow_namespace ? 1 : 0

  metadata {
    name = "kubeflow"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}

resource "kubernetes_config_map" "argocd-deploykf-plugin" {
  count = var.install_argocd_deploykf_plugin ? 1 : 0

  metadata {
    name      = "argocd-deploykf-plugin"
    namespace = var.argocd_namespace
  }

  data = {
    "plugin.yaml" = data.http.argocd-deploykf-plugin.response_body
  }
}

resource "kubernetes_persistent_volume_claim" "argocd-deploykf-plugin-assets" {
  count = var.install_argocd_deploykf_plugin ? 1 : 0

  metadata {
    name      = "argocd-deploykf-plugin-assets"
    namespace = var.argocd_namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }

    storage_class_name = var.storage_class_name
  }

  wait_until_bound = false
}

# https://github.com/deployKF/deployKF/tree/main/argocd-plugin#install-plugin---existing-argocd
# https://raw.githubusercontent.com/deployKF/deployKF/main/argocd-plugin/argocd-install/deploykf-plugin/repo-server-patch.yaml
# (modified due to installation by helm which has a prefixed deployment name)
resource "null_resource" "patch-argocd-repo-server" {
  provisioner "local-exec" {
    command = <<EOF
      tmpfile=$(mktemp /tmp/tf.XXXXXX)
      cp -v ${path.module}/files/argocd-repo-server-patch.yaml "$tmpfile"
      sed -i 's/#name#/${var.argocd_deployment_name}/g' "$tmpfile"
      kubectl patch deployment ${var.argocd_deployment_name} --namespace=${var.argocd_namespace} --patch-file="$tmpfile"
      rm "$tmpfile"
    EOF
  }

  depends_on = [
    helm_release.argo-cd,
    kubernetes_config_map.argocd-deploykf-plugin,
    kubernetes_persistent_volume_claim.argocd-deploykf-plugin-assets
  ]
}

resource "kubernetes_manifest" "app-of-apps" {
  count = var.install_app_of_apps ? 1 : 0

  manifest = yamldecode(templatefile("${path.module}/files/app-of-apps.yaml.tftpl", {
    values = indent(12, templatefile("${path.module}/files/app-of-apps-values.yaml.tftpl", {
      "custom_values" = var.app_of_apps_values
      "bucket"        = var.pipelines_bucket_name
      "region"        = var.region
      "iam_role_arn"  = local.iam_role_arn
      "mysql_host"    = local.mysql_host
    }))
    name           = var.app_of_apps_name
    namespace      = var.argocd_namespace
    repoURL        = var.deploykf_repo_url
    targetRevision = var.deploykf_repo_ref
    sourceYaml = templatefile("${path.module}/files/generator-source.yaml.tftpl", {
      sourceType   = var.deploykf_plugin_source_path == null ? "version" : "path"
      sourceString = var.deploykf_plugin_source_path == null ? var.deploykf_plugin_source_version : var.deploykf_plugin_source_path
    })
  }))

  depends_on = [
    helm_release.argo-cd,
    module.kubeflow-mysql-instance,
  ]
}

resource "kubernetes_secret" "kubeflow-db-credentials" {
  count = var.provision_rds_instance ? 1 : 0

  metadata {
    name      = "kubeflow-db-credentials"
    namespace = "kubeflow"
  }

  data = {
    "username" = var.kubeflow_database_user
    "password" = local.mysql_database_password
  }

  depends_on = [
    kubernetes_namespace.kubeflow
  ]
}
