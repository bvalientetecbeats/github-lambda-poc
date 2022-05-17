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
  vpc_id                       = "vpc-0ae3165a2f7ea3dd6"
  subnets                      = ["subnet-0c261f6e788ba40e8", "subnet-0867ad73689ae00e5", "subnet-0decaae92fd78f548"]
}