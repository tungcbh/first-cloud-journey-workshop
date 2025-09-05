
# First Cloud Journey Workshop

This repository contains labs for the **First Cloud Journey (FCJ) Program**, focusing on **Infrastructure as Code (IaC)** using **Terraform**.

## 📌 Project Overview

This project demonstrates how to provision cloud infrastructure using **Terraform**.
It supports both **local backend** (default) and **remote backend with AWS S3** for state management.

---

## 🚀 Prerequisites

Before starting, make sure you have:

* [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (`>=1.5.x`)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with your credentials
* An AWS account with permissions to create S3 bucket, DynamoDB table (for state locking), and resources defined in Terraform

---


---

## ⚙️ Backend Configuration

### 1. Local Backend (default)

By default, Terraform stores the state file (`terraform.tfstate`) in your project folder.
Example:

```hcl
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
```

### 2. Remote Backend with AWS S3 (recommended for team work)

To enable collaboration and safe state management, you can use **S3 as backend** with **DynamoDB for state locking**.

Example `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-backend"
    key            = "workshop/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

You need to **create the S3 bucket and DynamoDB table** before running `terraform init`.

---

## 🔨 Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate configuration

```bash
terraform validate
```

### 3. Preview the execution plan

```bash
terraform plan
```

### 4. Apply changes

```bash
terraform apply
```

### 5. Destroy infrastructure

```bash
terraform destroy
```

---

## 🧹 Cleanup

* If using local backend → just remove `.terraform` folder and `terraform.tfstate` file.
* If using S3 backend → remember to empty and delete the S3 bucket and DynamoDB table after finishing.

---


