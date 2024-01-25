<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.31.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.2 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa-ebs-csi"></a> [irsa-ebs-csi](#module\_irsa-ebs-csi) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_kubeflow-eks-cluster"></a> [kubeflow-eks-cluster](#module\_kubeflow-eks-cluster) | terraform-aws-modules/eks/aws | 19.15.3 |
| <a name="module_kubeflow-mysql-instance"></a> [kubeflow-mysql-instance](#module\_kubeflow-mysql-instance) | cloudposse/rds/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs-csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_policy.kubeflow-storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.kubeflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.kubeflow-storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.argocd-server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.kubeflow-pipelines](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [helm_release.argo-cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.argocd-deploykf-plugin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_manifest.app-of-apps](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.argo-cd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.deploykf-auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.kubeflow](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_persistent_volume_claim.argocd-deploykf-plugin-assets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume_claim) | resource |
| [kubernetes_secret.kubeflow-db-credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [null_resource.patch-argocd-repo-server](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.kubeflow_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.kubeflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy.ebs_csi_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_route53_zone.kubeflow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [http_http.argocd-deploykf-plugin](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | Manages [`aws_eks_addon`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) resources. | <pre>list(object({<br>    addon_name               = string<br>    addon_version            = string<br>    resolve_conflicts        = string<br>    service_account_role_arn = string<br>  }))</pre> | `[]` | no |
| <a name="input_app_of_apps_values"></a> [app\_of\_apps\_values](#input\_app\_of\_apps\_values) | Application values for the 'app of apps' argocd application | `string` | `""` | no |
| <a name="input_apply_config_map_aws_auth"></a> [apply\_config\_map\_aws\_auth](#input\_apply\_config\_map\_aws\_auth) | Whether to apply the ConfigMap to allow worker nodes to join the EKS cluster and allow additional users, accounts and roles to acces the cluster | `bool` | `false` | no |
| <a name="input_argocd_chart_version"></a> [argocd\_chart\_version](#input\_argocd\_chart\_version) | n/a | `string` | `"5.51.6"` | no |
| <a name="input_argocd_helm_values"></a> [argocd\_helm\_values](#input\_argocd\_helm\_values) | Helm values for the argocd deployment | `string` | `""` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | n/a | `string` | `"argocd"` | no |
| <a name="input_cluster_encryption_config_enabled"></a> [cluster\_encryption\_config\_enabled](#input\_cluster\_encryption\_config\_enabled) | Set to `true` to enable Cluster Encryption Configuration | `bool` | `true` | no |
| <a name="input_cluster_encryption_config_kms_key_deletion_window_in_days"></a> [cluster\_encryption\_config\_kms\_key\_deletion\_window\_in\_days](#input\_cluster\_encryption\_config\_kms\_key\_deletion\_window\_in\_days) | Cluster Encryption Config KMS Key Resource argument - key deletion windows in days post destruction | `number` | `10` | no |
| <a name="input_cluster_encryption_config_kms_key_enable_key_rotation"></a> [cluster\_encryption\_config\_kms\_key\_enable\_key\_rotation](#input\_cluster\_encryption\_config\_kms\_key\_enable\_key\_rotation) | Cluster Encryption Config KMS Key Resource argument - enable kms key rotation | `bool` | `true` | no |
| <a name="input_cluster_encryption_config_kms_key_id"></a> [cluster\_encryption\_config\_kms\_key\_id](#input\_cluster\_encryption\_config\_kms\_key\_id) | KMS Key ID to use for cluster encryption config | `string` | `""` | no |
| <a name="input_cluster_encryption_config_kms_key_policy"></a> [cluster\_encryption\_config\_kms\_key\_policy](#input\_cluster\_encryption\_config\_kms\_key\_policy) | Cluster Encryption Config KMS Key Resource argument - key policy | `string` | `null` | no |
| <a name="input_cluster_encryption_config_resources"></a> [cluster\_encryption\_config\_resources](#input\_cluster\_encryption\_config\_resources) | Cluster Encryption Config Resources to encrypt, e.g. ['secrets'] | `list(any)` | <pre>[<br>  "secrets"<br>]</pre> | no |
| <a name="input_cluster_log_retention_period"></a> [cluster\_log\_retention\_period](#input\_cluster\_log\_retention\_period) | Number of days to retain cluster logs. Requires `enabled_cluster_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. | `number` | `0` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to deploy kubeflow to (and to create if chosen) | `string` | `"kubeflow"` | no |
| <a name="input_create_argocd_namespace"></a> [create\_argocd\_namespace](#input\_create\_argocd\_namespace) | n/a | `bool` | `true` | no |
| <a name="input_create_databases"></a> [create\_databases](#input\_create\_databases) | n/a | `bool` | `false` | no |
| <a name="input_create_deploykf_auth_namespace"></a> [create\_deploykf\_auth\_namespace](#input\_create\_deploykf\_auth\_namespace) | n/a | `bool` | `true` | no |
| <a name="input_create_eks_cluster"></a> [create\_eks\_cluster](#input\_create\_eks\_cluster) | n/a | `bool` | `false` | no |
| <a name="input_create_iam_resources"></a> [create\_iam\_resources](#input\_create\_iam\_resources) | n/a | `bool` | `false` | no |
| <a name="input_create_kubeflow_namespace"></a> [create\_kubeflow\_namespace](#input\_create\_kubeflow\_namespace) | n/a | `bool` | `true` | no |
| <a name="input_create_s3_buckets"></a> [create\_s3\_buckets](#input\_create\_s3\_buckets) | n/a | `bool` | `false` | no |
| <a name="input_create_zone_records"></a> [create\_zone\_records](#input\_create\_zone\_records) | n/a | `bool` | `false` | no |
| <a name="input_deploykf_repo_ref"></a> [deploykf\_repo\_ref](#input\_deploykf\_repo\_ref) | n/a | `string` | `"v0.1.3"` | no |
| <a name="input_deploykf_repo_url"></a> [deploykf\_repo\_url](#input\_deploykf\_repo\_url) | n/a | `string` | `"https://github.com/thesuperzapper/deployKF.git"` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of worker nodes | `number` | `2` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided | `number` | `20` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`] | `list(string)` | `[]` | no |
| <a name="input_existing_eks_cluster"></a> [existing\_eks\_cluster](#input\_existing\_eks\_cluster) | Use an existing eks cluster | `bool` | `false` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Route 53 hosted zone name for dns records | `any` | `null` | no |
| <a name="input_hosted_zone_private"></a> [hosted\_zone\_private](#input\_hosted\_zone\_private) | Whether the hosted zone is private | `bool` | `false` | no |
| <a name="input_install_app_of_apps"></a> [install\_app\_of\_apps](#input\_install\_app\_of\_apps) | n/a | `bool` | `false` | no |
| <a name="input_install_argocd"></a> [install\_argocd](#input\_install\_argocd) | n/a | `bool` | `true` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Set of instance types associated with the EKS Node Group. | `map` | <pre>{<br>  "default": "t3.small",<br>  "rancher-0": "t3.small",<br>  "rancher-1": "t3.small"<br>}</pre> | no |
| <a name="input_kubeflow_database_name"></a> [kubeflow\_database\_name](#input\_kubeflow\_database\_name) | n/a | `string` | `"kubeflow"` | no |
| <a name="input_kubeflow_database_password"></a> [kubeflow\_database\_password](#input\_kubeflow\_database\_password) | The kubeflow database password | `string` | `""` | no |
| <a name="input_kubeflow_database_user"></a> [kubeflow\_database\_user](#input\_kubeflow\_database\_user) | n/a | `string` | `"kubeflow"` | no |
| <a name="input_kubeflow_iam_role_arn"></a> [kubeflow\_iam\_role\_arn](#input\_kubeflow\_iam\_role\_arn) | The IAM role ARN to use for kubeflow (optional) | `any` | `null` | no |
| <a name="input_kubernetes_config_map_ignore_role_changes"></a> [kubernetes\_config\_map\_ignore\_role\_changes](#input\_kubernetes\_config\_map\_ignore\_role\_changes) | Set to `true` to ignore IAM role changes in the Kubernetes Auth ConfigMap | `bool` | `true` | no |
| <a name="input_kubernetes_labels"></a> [kubernetes\_labels](#input\_kubernetes\_labels) | Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed | `map(string)` | `{}` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Desired Kubernetes master version. If you do not specify a value, the latest available version is used | `string` | `"1.26"` | no |
| <a name="input_local_exec_interpreter"></a> [local\_exec\_interpreter](#input\_local\_exec\_interpreter) | shell to use for local\_exec | `list(string)` | <pre>[<br>  "/bin/sh",<br>  "-c"<br>]</pre> | no |
| <a name="input_map_additional_iam_roles"></a> [map\_additional\_iam\_roles](#input\_map\_additional\_iam\_roles) | Additional IAM role mappings to add to aws-auth configmap | `list` | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "rolearn": "arn:aws:iam::631165420711:role/AWSReservedSSO_CloudAdmin_g_2e075014822efad3",<br>    "username": "cloud-admin-g"<br>  },<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "rolearn": "arn:aws:iam::631165420711:role/PhxBuildAgentRole",<br>    "username": "phx-build-agent-role"<br>  }<br>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the AutoScaling Group | `number` | `3` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the AutoScaling Group | `number` | `2` | no |
| <a name="input_mysql_host"></a> [mysql\_host](#input\_mysql\_host) | Hostname to connect to for the mysql database server | `string` | `"localhost"` | no |
| <a name="input_node_role_arn"></a> [node\_role\_arn](#input\_node\_role\_arn) | IAM role ARN to use for nodes in the worker group(s) | `string` | `"arn:aws:iam::631165420711:role/cp-core-eks-nodegroup-default-NodeInstanceRole"` | no |
| <a name="input_oidc_provider_enabled"></a> [oidc\_provider\_enabled](#input\_oidc\_provider\_enabled) | Create an IAM OIDC identity provider for the cluster, then you can create IAM roles to associate with a service account in the cluster, instead of using `kiam` or `kube2iam`. For more information, see https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html | `bool` | `true` | no |
| <a name="input_pipelines_bucket_name"></a> [pipelines\_bucket\_name](#input\_pipelines\_bucket\_name) | n/a | `string` | `"kubeflow-pipelines"` | no |
| <a name="input_provision_eks"></a> [provision\_eks](#input\_provision\_eks) | provision eks cluster and node group | `bool` | `false` | no |
| <a name="input_provision_rds_instance"></a> [provision\_rds\_instance](#input\_provision\_rds\_instance) | n/a | `bool` | `false` | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | Size in gigabytes to allocate to the rds instance | `number` | `20` | no |
| <a name="input_rds_allow_major_version_upgrade"></a> [rds\_allow\_major\_version\_upgrade](#input\_rds\_allow\_major\_version\_upgrade) | Allow major version upgrade | `bool` | `false` | no |
| <a name="input_rds_apply_immediately"></a> [rds\_apply\_immediately](#input\_rds\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_rds_auto_minor_version_upgrade"></a> [rds\_auto\_minor\_version\_upgrade](#input\_rds\_auto\_minor\_version\_upgrade) | Allow automated minor version upgrade | `bool` | `true` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | Backup retention period in days. Must be > 0 to enable backups | `number` | `0` | no |
| <a name="input_rds_backup_window"></a> [rds\_backup\_window](#input\_rds\_backup\_window) | When AWS can perform DB snapshots, can't overlap with maintenance window | `string` | `"22:00-03:00"` | no |
| <a name="input_rds_copy_tags_to_snapshot"></a> [rds\_copy\_tags\_to\_snapshot](#input\_rds\_copy\_tags\_to\_snapshot) | Copy tags from DB to a snapshot | `bool` | `true` | no |
| <a name="input_rds_database_port"></a> [rds\_database\_port](#input\_rds\_database\_port) | n/a | `number` | `3306` | no |
| <a name="input_rds_db_parameter_group"></a> [rds\_db\_parameter\_group](#input\_rds\_db\_parameter\_group) | n/a | `string` | `"mysql8.0"` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | n/a | `string` | `"mysql"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | n/a | `string` | `"8.0.35"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | Instance type for the rds instance | `string` | `"db.t3.small"` | no |
| <a name="input_rds_kms_key_arn"></a> [rds\_kms\_key\_arn](#input\_rds\_kms\_key\_arn) | The KMS Key ARN used for encryption with the storage | `any` | `null` | no |
| <a name="input_rds_maintenance_window"></a> [rds\_maintenance\_window](#input\_rds\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC | `string` | `"Mon:03:00-Mon:04:00"` | no |
| <a name="input_rds_major_engine_version"></a> [rds\_major\_engine\_version](#input\_rds\_major\_engine\_version) | n/a | `string` | `"8.0"` | no |
| <a name="input_rds_name_prefix"></a> [rds\_name\_prefix](#input\_rds\_name\_prefix) | Prefix string to use for the RDS database name | `string` | `"kubeflow-poc"` | no |
| <a name="input_rds_skip_final_snapshot"></a> [rds\_skip\_final\_snapshot](#input\_rds\_skip\_final\_snapshot) | If true (default), no snapshot will be made before deleting DB | `bool` | `false` | no |
| <a name="input_rds_subnet_ids"></a> [rds\_subnet\_ids](#input\_rds\_subnet\_ids) | VPC subnet IDs for the rds instance | `list` | `[]` | no |
| <a name="input_rds_vpc_id"></a> [rds\_vpc\_id](#input\_rds\_vpc\_id) | VPC ID for the rds instance | `any` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_storage_class_name"></a> [storage\_class\_name](#input\_storage\_class\_name) | n/a | `any` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to use for the eks cluster | `list(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC to deploy eks cluster to | `any` | `null` | no |

## Outputs

No outputs.
<!-- markdownlint-restore -->
