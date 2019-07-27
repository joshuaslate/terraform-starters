resource "aws_ecr_repository" "main" {
  name = "${var.project_name}"
}

resource "aws_ecr_lifecycle_policy" "expiration_policy" {
  repository = "${aws_ecr_repository.main.name}"

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["v"],
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
