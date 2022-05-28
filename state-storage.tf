resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "amiblocked.io.tfstate"

  versioning {
    # enable with caution, makes deleting S3 buckets tricky
    enabled = false
  }

  lifecycle {
    prevent_destroy = true
  }

}

# create a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "example-iac-terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

}
