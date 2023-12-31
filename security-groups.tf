resource "aws_security_group" "this" {
  vpc_id = local.vpc_id
  name   = local.resource_name
  tags   = merge(local.tags, { Name = local.resource_name })
}

resource "aws_security_group" "user" {
  vpc_id = local.vpc_id
  name   = "mysql-user/${local.resource_name}"
  tags   = merge(local.tags, { Name = "mysql-user/${local.resource_name}" })
}

resource "aws_security_group_rule" "this-from-user" {
  security_group_id        = aws_security_group.this.id
  protocol                 = "tcp"
  type                     = "ingress"
  from_port                = local.port
  to_port                  = local.port
  source_security_group_id = aws_security_group.user.id
}

resource "aws_security_group_rule" "user-to-this" {
  security_group_id        = aws_security_group.user.id
  protocol                 = "tcp"
  type                     = "egress"
  from_port                = local.port
  to_port                  = local.port
  source_security_group_id = aws_security_group.this.id
}
