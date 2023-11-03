# Serverless app in AWS with Terraform

## 1 - Database

Create a serverless database for movie app in DynamoDB

```sh
# Move to database directory
cd 1-database 
# Get plugins and modules
terraform init
# Dry run to validate resources to create
terraform plan
# expected output:
# Plan: 6 to add, 0 to change, 0 to destroy.
# Create resouces
terraform apply
# If you want destroy resouces
terraform destroy
```

## 2 - Backend

Create serverless backend for movie app using lamdba y API Gateway

```sh
# Move to backend directory
cd 2-backend 
# Get plugins and modules
terraform init
# Dry run to validate resources to create
terraform plan
# expected output:
# Plan: 9 to add, 0 to change, 0 to destroy.
# Create resouces
terraform apply
# If you want destroy resouces
terraform destroy
```

## 3 - Frontend

Create serverless backend for movie app using lamdba y API Gateway

```sh
# Move to frontend directory
cd 3-frontend 
# Get plugins and modules
terraform init
# Dry run to validate resources to create
terraform plan
# expected output:
# Plan: 11 to add, 0 to change, 0 to destroy.
# Create resouces
terraform apply
# If you want destroy resouces
terraform destroy
```
