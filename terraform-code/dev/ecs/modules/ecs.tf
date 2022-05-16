# Elastic Container Service
resource "aws_ecs_cluster" "main" {
  name = "react-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "react-task"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = file(".task-definition.json")
  }

resource "aws_ecs_service" "main" {
  name            = "react-service"
  cluster         = data.aws_ecs_cluster.main.id
  task_definition = data.aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.aws_alb_target_group.app.id
    container_name   = "react-poc"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}