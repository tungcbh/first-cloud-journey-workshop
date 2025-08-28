
# First Cloud Journey - AWS Deployment with Terraform

## 📌 Mục tiêu
Triển khai hạ tầng AWS bao gồm:
- VPC, Subnet, Security Groups
- RDS MySQL
- EC2 Instance (chạy Node.js App)
- Tự động provision DB và deploy app bằng script `setup_app.sh`

---


## 🚀 Cách triển khai

### 1. Khởi tạo Terraform
```bash
terraform init
````

### 2. Kiểm tra plan

```bash
terraform plan -var-file="backend.tfvars"
```

### 3. Apply hạ tầng

```bash
terraform apply -var-file="backend.tfvars" -auto-approve
```

---

## 🔑 SSH vào EC2

Trên Linux/macOS:

```bash
chmod 400 ec2_ssh_key.pem
ssh -i ec2_ssh_key.pem ec2-user@<EC2_PUBLIC_IP>
```

Trên Windows (PowerShell):

```powershell
icacls .\ec2_ssh_key.pem /inheritance:r
icacls .\ec2_ssh_key.pem /grant:r "$($env:USERNAME):(R)"
ssh -i ec2_ssh_key.pem ec2-user@<EC2_PUBLIC_IP>
```

---

## 🗄️ Database

* RDS MySQL được tạo tự động
* DB được init từ `init_db.sql`
* App sử dụng `.env` để kết nối DB

---

## 📜 Ghi chú

* File `ec2_ssh_key.pem` được tạo tự động khi chạy Terraform (không commit lên Git)
* Nếu deploy lại nhiều lần, cần kiểm tra DB table tránh lỗi trùng lặp
