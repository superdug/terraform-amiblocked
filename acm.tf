# SSL Certificate
resource "aws_acm_certificate" "default" {
  provider = aws.acm_provider
  domain_name = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  #validation_method = "EMAIL"
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_type
  zone_id         = var.zone_id
  //records = ["${aws_acm_certificate.default.domain_validation_options.resource_record_value}"]
  ttl             = "60"
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.validation.fqdn}",
  ]
}