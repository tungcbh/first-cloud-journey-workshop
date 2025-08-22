resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}

resource "aws_iam_user_group_membership" "membership" {
  user   = var.user_name
  groups = [aws_iam_group.this.name]
}

