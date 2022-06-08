
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

resource "aws_route53_record" "caa" {
  allow_overwrite = true
  zone_id         = var.zone_id
  name            = var.domain_name
  type            = "CAA"
  ttl             = 86400

  records         = ["0 issue \"amazontrust.com\"","0 issue \"awstrust.com\"","0 issue \"amazon.com\"","0 issue \"amazonaws.com\""]

  lifecycle {
    create_before_destroy = false
  }
}