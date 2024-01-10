variable "argocd_helm_values" {
  default     = ""
  description = "Helm values for the argocd deployment"
}

variable "install_app_of_apps" {
  type    = bool
  default = false
}
