resource "aws_route53_record" "argocd-server" {
  count   = var.create_zone_records ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = "argocd"
  type    = "CNAME"
  ttl     = 60
  records = [""]
}
