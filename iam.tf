# NOTE: allows all namespaces until enhanced
resource "aws_iam_role" "kubeflow" {
  count = var.create_iam_resources ? 1 : 0

  name               = "kubeflow"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Kubeflow",
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity[0].current.account_id}:oidc-provider/${local.eks_oidc_issuer}"
      },
      "Condition": {
        "StringLike": {
          "${local.eks_oidc_issuer}:sub": "system:serviceaccount:*:*"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "kubeflow-storage" {
  count = var.create_iam_resources ? 1 : 0

  name        = "kubeflow-pipelines-storage"
  path        = "/"
  description = "External storage for Kubeflow Pipelines"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.kubeflow-pipelines[0].bucket}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.kubeflow-pipelines[0].bucket}/artifacts/*",
        "arn:aws:s3:::${aws_s3_bucket.kubeflow-pipelines[0].bucket}/pipelines/*",
        "arn:aws:s3:::${aws_s3_bucket.kubeflow-pipelines[0].bucket}/v2/artifacts/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kubeflow-storage" {
  count = var.create_iam_resources && var.create_eks_cluster ? 1 : 0

  role       = aws_iam_role.kubeflow[0].name
  policy_arn = aws_iam_policy.kubeflow-storage[0].arn

  depends_on = [
    aws_iam_policy.kubeflow-storage
  ]
}
