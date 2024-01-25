variable "app_of_apps_values" {
  default     = ""
  description = "Application values for the 'app of apps' argocd application"
}

variable "argocd_helm_values" {
  default     = ""
  description = "Helm values for the argocd deployment"
}

variable "argocd_namespace" {
  default = "argocd"
}

variable "argocd_chart_version" {
  default = "5.51.6"
}

variable "cluster_name" {
  default     = "kubeflow"
  description = "The name of the cluster to deploy kubeflow to (and to create if chosen)"
}

variable "create_eks_cluster" {
  type    = bool
  default = false
}

variable "create_iam_resources" {
  type    = bool
  default = false
}

variable "create_argocd_namespace" {
  type    = bool
  default = true
}

variable "create_databases" {
  type    = bool
  default = false
}

variable "create_s3_buckets" {
  type    = bool
  default = false
}

variable "create_zone_records" {
  type    = bool
  default = false
}

variable "deploykf_repo_url" {
  default = "https://github.com/thesuperzapper/deployKF.git"
}

variable "deploykf_repo_ref" {
  default = "v0.1.3"
}

variable "existing_eks_cluster" {
  type        = bool
  default     = false
  description = "Use an existing eks cluster"
}

variable "hosted_zone_id" {
  default     = null
  description = "Route 53 hosted zone name for dns records"
}

variable "hosted_zone_private" {
  default     = false
  description = "Whether the hosted zone is private"
}

variable "install_argocd" {
  type    = bool
  default = true
}

variable "install_app_of_apps" {
  type    = bool
  default = false
}

variable "kubeflow_database_name" {
  default = "kubeflow"
}

variable "kubeflow_database_user" {
  default = "kubeflow"
}

variable "kubeflow_database_password" {
  default     = ""
  description = "The kubeflow database password"
}

variable "kubeflow_iam_role_arn" {
  default     = null
  description = "The IAM role ARN to use for kubeflow (optional)"
}


variable "mysql_host" {
  default     = "localhost"
  description = "Hostname to connect to for the mysql database server"
}

variable "pipelines_bucket_name" {
  default = "kubeflow-pipelines"
}

variable "provision_rds_instance" {
  type    = bool
  default = false
}

variable "region" {
  default = "us-east-1"
}

variable "storage_class_name" {
  default = null
}

variable "subnet_ids" {
  default     = null
  type        = list(string)
  description = "List of subnet IDs to use for the eks cluster"
}

variable "vpc_id" {
  default     = null
  description = "ID of VPC to deploy eks cluster to"
}
