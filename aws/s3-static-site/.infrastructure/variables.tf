variable "environment_domain_prefix" {
  description = "The domain prefix for the environment being created (e.g., staging., dev.), with a trailing '.'"
  default     = ""
}

variable "root_domain_name" {
  description = "The root domain name for your application"
  default     = ""
}

variable "app_domain_prefix" {
  description = "The domain prefix for the application (e.g., app., ui., admin., dashboard.), with a trailing '.'"
  default     = ""
}

variable "default_region" {
  description = "The AWS region to deploy your application's assets in"
  default     = ""
}

variable "project_name" {
  description = "The name of your application (can be used for tagging)"
  default     = "frontend-app"
}

variable "environment" {
  description = "The environment this infrastructure is being created for (e.g., staging, production, development)"
  default     = "production"
}
