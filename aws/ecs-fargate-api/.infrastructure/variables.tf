variable "environment" {
  description = "Name of the environment (e.g., staging, production, development)"
  default     = "production"
}

variable "project_name" {
  description = "Name of the project infrastructure is being created for (used for container name, cluster naming, etc.)"
  default     = "app"
}

variable "environment_domain_prefix" {
  description = "The domain prefix for the environment being created (e.g., staging., dev.), with a trailing '.'"
  default     = ""
}

variable "root_domain_name" {
  description = "The root domain name for your application"
  default     = ""
}

variable "api_domain_prefix" {
  description = "The domain prefix for the API (e.g., api., backend., graphql.), with a trailing '.'"
  default     = ""
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default     = "myEcsAutoScaleRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_port" {
  description = "Port exposed by the Docker container to redirect traffic to"
  default     = 4000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "health_check_path" {
  default = "/health"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "min_capacity" {
  default = 0
}

variable "max_capacity" {
  default = 3
}

variable "aws_account_id" {
  default = ""
}
