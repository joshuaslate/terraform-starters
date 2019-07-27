# ECS Fargate API

## Infrastructure

### Preparation

You will need to create an SSL Certificate in the AWS region of your choosing, which can be created in the [AWS console](https://aws.amazon.com/certificate-manager/).

Create your own `*.tfvars` file for each environment you would like to create infrastructure for, based on the `example.tfvars` file.

To allow Terraform to maintain state, we'll create an S3 bucket. Create an S3 bucket in the region of your choice to maintain this state, then modify `main.tf` with the region and bucket name you used.

### Creating

Once your certificate is created and verified and your variables have been added, you are ready to create infrastructure.

Replace `*.tfvars` with the name of the variable file you'd like to use.

```
terraform init
terraform plan -var-file="*.tfvars"
terraform apply -var-file="*.tfvars"
```

### Destroying

```
terraform destroy -var-file="*.tfvars"
```

## CI/CD

Set up a CircleCI account and set up your repository. As things are configured, a merge to master will trigger a deployment.

### Preparation

You will need to set the following environment variables for the project in CircleCI:

```
AWS_DEFAULT_REGION=<The AWS Region You Configured for Terraform>
AWS_SECRET_ACCESS_KEY=<A Secret Access Key You Setup for CircleCI in AWS>
AWS_ACCESS_KEY_ID=<Access Key ID You Setup for CircleCI in AWS>
AWS_ACCOUNT_ID=<The ID for Your AWS Account>
AWS_ECR_REPO_NAME=<The Name of Your ECR Repository>
AWS_ECR_ACCOUNT_URL=<URL to ECR Registry, e.g. aws_account_id.dkr.ecr.region.amazonaws.com, (Change aws_account_id and region accordingly)>
AWS_RESOURCE_NAME_PREFIX=<Should Match aws_ecs_service.main Resource Name in ecr.tf, minus "-service">
```

## Credit
I put this together by following [a tutorial by Bradford Lamson-Scribner](https://medium.com/@bradford_hamilton/deploying-containers-on-amazons-ecs-using-fargate-and-terraform-part-2-2e6f6a3a957f) and making modifications to meet my needs. I would highly recommend reading through this tutorial. Thank you for providing such a great resource.
