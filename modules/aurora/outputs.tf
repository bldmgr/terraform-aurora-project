output "cluster_identifier" {
  description = "Aurora cluster identifier"
  value = aws_rds_cluster.aurora_postgresql.id
}

output "endpoint" {
  description = "Aurora cluster writer endpoint"
  value = aws_rds_cluster.aurora_postgresql.endpoint
}

output "reader_endpoint" {
  description = "Aurora cluster reader endpoint"
  value = aws_rds_cluster.aurora_postgresql.reader_endpoint
}

output "port" {
  description = "Aurora cluster port"
  value = aws_rds_cluster.aurora_postgresql.port
}

output "instance_identifiers" {
  description = "List of Aurora instance identifiers"
  value = aws_rds_cluster_instance.aurora_instance[*].identifier
}

output "instance_endpoints" {
  description = "List of Aurora instance endpoints"
  value = aws_rds_cluster_instance.aurora_instance[*].endpoint
}

output "cluster_parameter_group_name" {
  description = "Aurora cluster parameter group name"
  value = aws_rds_cluster_parameter_group.aurora_parameter_group.name
}

output "db_parameter_group_name" {
  description = "Aurora DB parameter group name"
  value = aws_db_parameter_group.aurora_db_parameter_group.name
}