provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "availabilityZone"
    values = ["${var.region}a"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

#linux instance
#linux instance
resource "aws_instance" "linux_instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Linux Instance"
    Size = var.instance_type
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Connected via SSH!'",
      "aws s3 ls" # test quyền truy cập S3
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }
}
