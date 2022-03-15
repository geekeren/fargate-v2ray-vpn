resource "aws_ecs_cluster" "vpn" {
  name = "vpn"
  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT",
  ]
  default_capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}

resource "aws_ecs_service" "vpn" {
  name                    = "vpn"
  cluster                 = aws_ecs_cluster.vpn.id
  task_definition         = aws_ecs_task_definition.v2ray_vpn.arn
  desired_count           = 1
  enable_ecs_managed_tags = true
  launch_type             = "FARGATE"
  network_configuration {
    assign_public_ip = true
    subnets          = module.vpc.public_subnets
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}
// arn:aws:ecs:ap-northeast-1:670065073730:task-definition/v2ray-vpn:6
resource "aws_ecs_task_definition" "v2ray_vpn" {
  family                   = "v2ray-vpn"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode(yamldecode(
    templatefile("./assets/ecs-task.yaml", {
      ddns_subdomain = var.ddns_subdomain
      ddns_token     = var.ddns_token
    })
  ))
}
