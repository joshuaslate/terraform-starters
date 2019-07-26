# Terraform Starters

This repository contains (hopefully) plug-and-play Terraform and CircleCI configurations to set up infrastructure and CI/CD pipelines for different types of applications.

This is currently a work in progress and shouldn't be used in production in its current state.

## Install

Install [Terraform](https://www.terraform.io/) and the CLI tools required for your provider (AWS, GCP, Azure, etc.).

## Use

To use these starters, you can copy the `.infrastructure` and `.circleci` folders into your project, then change your working directory to `.infrastructure`.

Please add your secrets to a `secrets.tfvars` file in your working directory, then run:


```
terraform init
terraform plan -var-file="secrets.tfvars"
terraform apply -var-file="secrets.tfvars"
```

Please note that you will be charged for resources you create using `terraform apply`. You can destroy all of the resources Terraform created by using:

```
terraform destroy -var-file="secrets.tfvars"
```

## Contribution

I'm by no means an infrastructure expert, and I would love to see these starters improve, become more secure, and more scalable. If you are up to sharing your expertise, please feel free to open a pull request.
