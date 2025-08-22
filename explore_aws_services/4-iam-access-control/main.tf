provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_group" "manager" {
  name = "manager-group"
}

resource "aws_iam_policy" "manager_policy" {
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
}

resource "aws_iam_policy_attachment" "manager_policy_attachment" {
  name       = "manager-policy-attachment"
  policy_arn = aws_iam_policy.manager_policy.arn
  groups     = [aws_iam_group.manager.name]
}


resource "aws_iam_user" "manager" {
  name = "manager-user"
  path = "/"
  tags = {
    "Department" = "Management"
  }
}

resource "aws_iam_access_key" "manager" {
  user = aws_iam_user.manager.name
}

data "aws_iam_policy_document" "manager_user_policy" {
  statement {
    sid    = "AllowS3Actions"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_user_policy" "manager_user_policy" {
  name   = "manager-user-policy"
  user   = aws_iam_user.manager.name
  policy = data.aws_iam_policy_document.manager_user_policy.json
}

resource "aws_iam_user_group_membership" "manager_user_group_membership" {
  user   = aws_iam_user.manager.name
  groups = [aws_iam_group.manager.name]
}
