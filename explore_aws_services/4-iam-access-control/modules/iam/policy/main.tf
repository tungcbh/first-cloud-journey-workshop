resource "aws_iam_policy" "this" {
  name        = var.name
  description = var.description
  policy      = var.policy
}

resource "aws_iam_policy_attachment" "this" {
  name       = "${var.name}-attachment"
  policy_arn = aws_iam_policy.this.arn
  groups     = var.groups
  roles      = var.roles
  users      = var.users
}
