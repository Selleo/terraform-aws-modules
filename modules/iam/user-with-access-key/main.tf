resource "aws_iam_user" "this" {
  name = var.name
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name

  depends_on = [
    aws_iam_user.this,
  ]
}

resource "aws_iam_user_group_membership" "this" {
  count = length(var.groups) > 0 ? 1 : 0

  user   = aws_iam_user.this.name
  groups = var.groups

  depends_on = [
    aws_iam_user.this,
  ]
}

resource "aws_iam_user_policy_attachment" "this" {
  count = length(var.policies)

  user       = aws_iam_user.this.name
  policy_arn = var.policies[count.index]

  depends_on = [
    aws_iam_user.this,
  ]
}
