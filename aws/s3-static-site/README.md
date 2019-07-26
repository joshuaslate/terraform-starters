# S3 Static Site

A static site hosted on AWS S3 with a CloudFront CDN is a great and fairly cost-effective way to host modern single page applications.

## Infrastructure

### Preparation

You will need to create an SSL Certificate in the AWS `us-east-1` region, which can be created in the [AWS console](https://aws.amazon.com/certificate-manager/).

Create your own `*.tfvars` file for each environment you would like to create infrastructure for, based on the `example.tfvars` file.

### Creating

Once your certificate is created and verified in `us-east-1` and your variables have been added, you are ready to create infrastructure.

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
DISTRIBUTION_ID=<Your CloudFront DistributionId>
AWS_DEFAULT_REGION=<The AWS Region You Configured for Terraform>
S3_BUCKET=<The Name of Your S3 Bucket>
AWS_SECRET_ACCESS_KEY=<A Secret Access Key You Setup for CircleCI in AWS>
AWS_ACCESS_KEY_ID=<Access Key ID You Setup for CircleCI in AWS>
```
