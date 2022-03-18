This project help you build a v2ray VPN on AWS fargate and a subscription config server on AWS S3

## Project Structure

- docker: Build DDNS service and v2ray service docker image
- cloud-fra: Build AWS Infra using terraform, including
    - Cloudfront CDN
    - Fargate serverless container servce
    - S3
    - Other fundamental infrastures like VPC, security group 
