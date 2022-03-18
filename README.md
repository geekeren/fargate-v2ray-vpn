This project help you build a v2ray VPN on AWS fargate and a subscription config server on AWS S3

## Project Structure

- docker: Build DDNS service and v2ray service docker image

    - building command
```shell
docker build . -f v2ray.Dockerfile -t bywang/vpn:8
docker build . -f ddns.Dockerfile -t bywang/ddns:9
```

- cloud-infra: Build AWS Infra using terraform, including
    - Cloudfront CDN
    - Fargate serverless container servce
    - S3
    - Other fundamental infrastures like VPC, security group 

  building command: 
 ```shell
terraform init
terraform apply --var-file ./environment/huangzhou.tfvars
 ```
