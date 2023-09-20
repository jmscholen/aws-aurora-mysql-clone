resource "aws_rds_cluster" "this" {
  cluster_identifier        = "${local.resource_name}-cloned-cluster"
  engine                    = "aurora-mysql"
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  
  port                      = local.port
  tags                      = local.tags
  
  master_username = replace(data.ns_workspace.this.block_ref, "-", "_")
  master_password = random_password.this.result
  skip_final_snapshot       = true
  restore_to_point_in_time {
    source_cluster_identifier  = var.source_cluster_identifier
    restore_type               = "copy-on-write"
    use_latest_restorable_time = true
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "preview-cloned-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.t4g.medium"
  engine             = "aurora-mysql"
}


resource "aws_db_subnet_group" "this" {
  name        = local.resource_name
  description = "Mysql db subnet group for mysql cluster"
  subnet_ids  = local.private_subnet_ids
  tags        = local.tags
}
