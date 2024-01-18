resource "aws_s3_bucket" "kubeflow-pipelines" {
  count  = var.create_s3_buckets ? 1 : 0
  bucket = var.pipelines_bucket_name
}
