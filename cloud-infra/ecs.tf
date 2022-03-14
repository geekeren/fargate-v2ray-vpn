resource "aws_ecs_cluster" "vpn" {
  name = "vpn"
}

resource "aws_ecs_service" "vpn" {
  name                    = "vpn"
  cluster                 = aws_ecs_cluster.vpn.id
  task_definition         = aws_ecs_task_definition.v2ray_vpn.arn
  desired_count           = 1
  enable_ecs_managed_tags = true
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

// arn:aws:ecs:ap-northeast-1:670065073730:task-definition/v2ray-vpn:6
resource "aws_ecs_task_definition" "v2ray_vpn" {
  family                   = "v2ray-vpn"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "v2ray",
    "image": "bywang/vpn",
    "essential": true
  },
  {
    "name": "ddns",
    "image": "bywang/ddns",
    "essential": true
  }
]
TASK_DEFINITION

}
