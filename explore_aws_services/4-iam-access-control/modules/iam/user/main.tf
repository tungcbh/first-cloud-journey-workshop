resource "aws_iam_user" "this" {
  name = var.name
  path = var.path
  tags = var.tags
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

