# Manage Usage and Cost in AWS

This section of the workshop focuses on exploring tools and strategies to manage and optimize usage and costs in AWS.

[Link to workshop](https://000007.awsstudygroup.com/1-cost-budgets/)


## Step 1: Config backend for store state
  You can use local backend without create S3 bucket and DynamoDB table
1.  **Add `backend.tfvars`**:

    ```hcl
    bucket = "your-unique-bucket-name"
    key    = "explore_aws_services/2-manage-usage-cost/terraform.tfstate"
    region = "us-east-1"
    ```
2.  **Install provider and init backend**
    * Open terminal or command shell.
    ```bash
    cd explore_aws_services/2-manage-usage-cost
    terraform init -backend-config="backend.tfvars"
    ```

## Step 2: Config `local.tfvars`and apply resources
1.  **Add `local.tfvars`**:

    ```hcl
    subscriber_email_addresses = [
      "your.email@example.com",
      "another.email@example.com"
    ]
    ```
2.  **Apply Terraform config**
    * Open terminal or command shell.
    ```bash
    terraform apply -var-file="local.tfvars"
    ```

## Step 3: Destroy resources
  * Open terminal or command shell.
  
    ```bash
    terraform destroy -auto-approve
    ```