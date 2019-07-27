resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}-cluster"
}

data "template_file" "service_task_definition_template" {
  template = file("./templates/ecs/service.json.tpl")

  vars = {
    app_image             = aws_ecr_repository.main.repository_url
    app_port              = var.app_port
    fargate_cpu           = var.fargate_cpu
    fargate_memory        = var.fargate_memory
    aws_region            = var.aws_region
    aws_account_id        = var.aws_account_id
    project_name          = var.project_name
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${var.project_name}-${var.environment}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.service_task_definition_template.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.api.id
    container_name   = "${var.project_name}"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.main_lb_listener, aws_alb_listener.main_lb_redirect_listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

