module "db_admin" {
  source = "api.nullstone.io/nullstone/aws-mysql-db-admin/aws"

  name     = local.resource_name
  tags     = local.tags
  host     = aws_rds_cluster.this.endpoint
  username = aws_rds_cluster.this.master_username
  password = random_password.this.result

  network = {
    vpc_id             = local.vpc_id
    security_group_ids = [aws_security_group.user.id]
    subnet_ids         = local.private_subnet_ids
  }
}
