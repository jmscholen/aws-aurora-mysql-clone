# aws-rds-aurora-cluster

Nullstone Block standing up AWS RDS Aurora MySQL Cloned Cluster and Instance

## Inputs

- `source_cluster_identifier: string` - RDS Instance ARN to clone

## Outputs

- `db_instance_arn: string` - RDS Instance ARN
- `db_master_secret_id: string` - ID of AWS Secrets Manager Secret that holds database master credentials
- `db_endpoint: string` - RDS Connection Endpoint
- `db_security_group_id: string` - Security Group ID for RDS Cluster
- `db_user_security_group_id: string` - Security Group ID - Attach to any instance to gain access to the aurora cluster
- `db_admin_function_name`: string - AWS Lambda Function Name for db admin utility
