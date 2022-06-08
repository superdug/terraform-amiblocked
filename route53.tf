
resource "aws_route53_record" "root-a" {
  zone_id = var.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = aws_cloudfront_distribution.root_s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.root_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = var.zone_id
  name = "www.${var.domain_name}"
  type = "A"

  alias {
    name = aws_cloudfront_distribution.www_s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.www_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "CAA-1" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = "5"

  records        = ["amazon.com"]
}

resource "aws_route53_record" "CAA-2" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = "5"

  records        = ["amazontrust.com"]
}

resource "aws_route53_record" "CAA-3" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = "5"

  records        = ["awstust.com"]
}

resource "aws_route53_record" "CAA-4" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = "5"

  records        = ["amazonaws.com"]
}