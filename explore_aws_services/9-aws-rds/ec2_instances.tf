#data
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"] # Amazon

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# ami = "ami-013e83f579886baeb"


#ec2_instances
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  subnet_id              = aws_subnet.public[0].id

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  provisioner "file" {
    source      = "${path.module}/setup_app.sh"
    destination = "/tmp/setup_app.sh"


    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "${path.module}/init_db.sql"
    destination = "/tmp/init_db.sql"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup_app.sh",
      "export DB_HOST=${aws_db_instance.mysql.address}",
      "export DB_NAME=${var.db_name}",
      "export DB_USER=${var.db_username}",
      "export DB_PASS=${var.db_password}",
      "/tmp/setup_app.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }

  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "ec2-instance"
  }
}

output "web_url" {
  value = "http://${aws_instance.ec2_instance.public_ip}:5000/"
}