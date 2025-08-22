provider "aws" {
  region = var.region
}

module "manager_user" {
  source = "./modules/iam/user"
  name   = "manager-user"
  tags = {
    Department = "Management"
  }
}

module "operator_user" {
  source = "./modules/iam/user"
  name   = "operator-user"
  tags = {
    Department = "Operations"
  }
}

module "manager_group" {
  source    = "./modules/iam/group"
  name      = "manager-group"
  user_name = module.manager_user.name
}

module "manager_policy" {
  source      = "./modules/iam/policy"
  name        = "manager-policy"
  description = "Policy for manager group"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
  groups = [module.manager_group.name]
  users  = [module.manager_user.name]
}

module "operator_policy" {
  source      = "./modules/iam/policy"
  name        = "operator-policy"
  description = "Policy for operator user"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = "*"
      }
    ]
  })
  users      = [module.operator_user.name]
  depends_on = [module.EC2_role]
}

module "EC2_role" {
  source = "./modules/iam/role"
  name   = "manager-role"
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

resource "aws_iam_user_login_profile" "manager_user" {
  user                    = module.manager_user.name
  password_length         = 10
  password_reset_required = true

}
