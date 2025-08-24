# Manage Usage and Cost in AWS

This section of the workshop is create IAM Role to grant S3 Full Access permission for EC2 Instance.

[Link to workshop](https://000048.awsstudygroup.com/)


## Step 1: Config backend for store state
  Note: You can use local backend without create S3 bucket and DynamoDB table
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

## Step 3: Destroy resources
  * Open terminal or command shell.
  
    ```bash
    terraform destroy -auto-approve
    ```