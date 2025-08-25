# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  count = var.create_eks_cluster ? 1 : 0

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "kubeflow-eks-cluster" {
  count   = var.create_eks_cluster ? 1 : 0
  source  = "terraform-aws-modules/eks/aws"
  version = "21.1.3"

  name                   = var.cluster_name
  kubernetes_version     = "1.33"
  vpc_id                 = var.vpc_id
  subnet_ids             = var.subnet_ids
  endpoint_public_access = true

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

data "aws_iam_policy" "ebs_csi_policy" {
  count = var.create_eks_cluster ? 1 : 0

  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  count = var.create_eks_cluster ? 1 : 0

  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.kubeflow-eks-cluster[0].cluster_name}"
  provider_url                  = module.kubeflow-eks-cluster[0].oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy[0].arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  count = var.create_eks_cluster ? 1 : 0

  cluster_name             = module.kubeflow-eks-cluster[0].cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.20.0-eksbuild.1"
  service_account_role_arn = module.irsa-ebs-csi[0].iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}
