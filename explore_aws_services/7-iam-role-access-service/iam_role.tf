resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_fullaccess_role"
  tags = {
    Name = "ec2_s3_fullaccess_role"
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_fullaccess" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_s3_fullaccess_profile"
  role = aws_iam_role.ec2_role.name
}
