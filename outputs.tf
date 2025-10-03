output "aurora_cluster_endpoint" {
  description = "Aurora cluster writer endpoint"
  value       = module.aurora.endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "Aurora cluster reader endpoint"  
  value       = module.aurora.reader_endpoint
}

output "aurora_cluster_port" {
  description = "Aurora cluster port"
  value       = module.aurora.port
}

output "aurora_cluster_id" {
  description = "Aurora cluster identifier"
  value       = module.aurora.cluster_identifier
}

output "aurora_instance_identifiers" {
  description = "List of Aurora instance identifiers"
  value       = module.aurora.instance_identifiers
}

output "aurora_instance_endpoints" {
  description = "List of Aurora instance endpoints"
  value       = module.aurora.instance_endpoints
}

output "aurora_security_group_id" {
  description = "Security group ID for Aurora"
  value       = module.security_groups.aurora_security_group_id
}

output "connection_info" {
  description = "Aurora connection information"
  value = {
    writer_endpoint = module.aurora.endpoint
    reader_endpoint = module.aurora.reader_endpoint
    port           = module.aurora.port
    username       = var.db_username
    database_name  = var.db_name
  }
}

output "aurora_parameter_groups" {
  description = "Aurora parameter group information"
  value = {
    cluster_parameter_group = module.aurora.cluster_parameter_group_name
    db_parameter_group      = module.aurora.db_parameter_group_name
  }
}