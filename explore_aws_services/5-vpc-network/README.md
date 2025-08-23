# Manage Usage and Cost in AWS

This section of the workshop is create VPC(subnet, route table, security group) and SSH connect.

[Link to workshop](https://000002.awsstudygroup.com/)


## Step 1: Config backend for store state
  Note: You can use local backend without create S3 bucket and DynamoDB table
1.  **Add `backend.tfvars`**:

    ```hcl
    bucket = "your-unique-bucket-name"
    key    = "explore_aws_services/5-vpc-network/terraform.tfstate"
    region = "us-east-1"
    ```
2.  **Install provider and init backend**
    * Open terminal or command shell.
    ```bash
    cd explore_aws_services/5-vpc-network
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