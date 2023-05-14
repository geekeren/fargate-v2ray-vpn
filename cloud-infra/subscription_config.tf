
resource "random_uuid" "file_name" {
}

resource "aws_s3_bucket" "subscription" {
  bucket = "v2ray-subscriptions"
  acl    = "private"
  tags = {
    Name = "v2ray_subscriptions"
  }
}

resource "aws_s3_bucket_ownership_controls" "subscription" {
  bucket = aws_s3_bucket.subscription.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "subscription" {
  bucket = aws_s3_bucket.subscription.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "subscription" {
  depends_on = [
    aws_s3_bucket_ownership_controls.subscription,
    aws_s3_bucket_public_access_block.subscription,
  ]

  bucket = aws_s3_bucket.subscription.id
  acl    = "public-read"
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.subscription.id
  key    = "configs.${random_uuid.file_name.result}.txt"
  acl    = "public-read"
  source = "assets/subscription_config.txt"
  etag   = filemd5("assets/subscription_config.txt")
}


output "v2ray_subscription_configs_url" {
  value = "https://${aws_s3_bucket.subscription.bucket_regional_domain_name}/${aws_s3_bucket_object.object.key}"
}