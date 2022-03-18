
resource "random_uuid" "file_name" {
}

resource "aws_s3_bucket" "subscription" {
  bucket = "v2ray-subscription-configs"
  acl    = "private"
  tags = {
    Name = "v2ray_subscription_configs"
  }
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