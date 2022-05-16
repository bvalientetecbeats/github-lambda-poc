module "ecs" {
  source                       = "./modules/"
  aws_region                   = var.aws_region
  tag_owner                    = var.tag_owner
  ecs_task_execution_role_name = "ReactEcsTaskExecutionRole"
  az_count                     = "2"
  app_port                     = 80
  app_count                    = 3
  health_check_path            = "/"
  fargate_cpu                  = "512"
  fargate_memory               = "1024"
  vpc_id                       = "vpc-0a6fc7a0840952a0d"
  subnets                      = ["subnet-0d59449d854dc3a0f", "subnet-0855130bdc2795e94", "subnet-068c79383d6173c35"]
}