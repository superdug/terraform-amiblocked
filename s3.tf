# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = var.bucket_name

  policy = templatefile("templates/s3-policy.json", { 
    bucket = var.bucket_name 
    }
  )
  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "www_bucket_acl" {
  bucket = aws_s3_bucket.www_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "www_bucket_cors" {
  bucket = aws_s3_bucket.www_bucket.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "www_bucket_website" {
  bucket = aws_s3_bucket.www_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


# S3 bucket for ROOT website.
resource "aws_s3_bucket" "root_bucket" {
  bucket = "root-${var.bucket_name}"

  policy = templatefile("templates/s3-policy.json", { 
    bucket = "root-${var.bucket_name}"
    }
  )
  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "root_bucket_acl" {
  bucket = aws_s3_bucket.root_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "root_bucket_website" {
  bucket = aws_s3_bucket.root_bucket.id

  redirect_all_requests_to {
    host_name = "www.${var.domain_name}"
    //protocol = "https"
  }
}