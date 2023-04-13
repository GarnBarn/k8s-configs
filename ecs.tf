resource "aws_ecs_cluster" "garnbarn-ecs-cluster" {
  name = "garnbarn-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
