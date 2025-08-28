# Tạo SSH key pair mới
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload public key lên AWS
resource "aws_key_pair" "deployer" {
  key_name   = "ec2_ssh_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Lưu private key ra local file (dùng để ssh sau này)
resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ec2_ssh_key.pem"
}
