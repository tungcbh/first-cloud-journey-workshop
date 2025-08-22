# Manage Usage and Cost in AWS

This section of the workshop focuses on using Identity and Access Management (IAM) in AWS.

[Link to workshop](https://000002.awsstudygroup.com/)


## Step 1: Config backend for store state
  You can use local backend without create S3 bucket and DynamoDB table
1.  **Add `backend.tfvars`**:

    ```hcl
    bucket = "your-unique-bucket-name"
    key    = "explore_aws_services/4-iam-access-control/terraform.tfstate"
    region = "us-east-1"
    ```
2.  **Install provider and init backend**
    * Open terminal or command shell.
    ```bash
    cd explore_aws_services/4-iam-access-control
    terraform init -backend-config="backend.tfvars"
    ```

## Step 2: Apply resources config 

1.  **Apply Terraform config**
    * Open terminal or command shell.
    ```bash
    terraform apply
    ```
