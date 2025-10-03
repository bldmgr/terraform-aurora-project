locals {
  cluster_identifier_clean = lower(replace(var.cluster_identifier, "_", "-"))
}

resource "aws_rds_cluster" "aurora_postgresql" {
  cluster_identifier              = local.cluster_identifier_clean
  engine                         = "aurora-postgresql"
  engine_version                 = var.engine_version
  master_username                = var.master_username
  master_password                = var.master_password
  database_name                  = lower(replace(var.database_name, "-", ""))
  skip_final_snapshot            = true
  vpc_security_group_ids         = var.security_group_ids
  db_subnet_group_name           = aws_db_subnet_group.aurora_subnet_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_parameter_group.name
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count                    = var.instance_count
  identifier               = "${local.cluster_identifier_clean}-${count.index == 0 ? "writer" : "reader-${count.index}"}"
  cluster_identifier       = aws_rds_cluster.aurora_postgresql.id
  instance_class           = var.instance_class
  engine                   = aws_rds_cluster.aurora_postgresql.engine
  engine_version           = aws_rds_cluster.aurora_postgresql.engine_version
  db_parameter_group_name  = aws_db_parameter_group.aurora_db_parameter_group.name
  
  tags = {
    Name = "${local.cluster_identifier_clean}-${count.index == 0 ? "writer" : "reader-${count.index}"}"
    Role = count.index == 0 ? "writer" : "reader"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${local.cluster_identifier_clean}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_rds_cluster_parameter_group" "aurora_parameter_group" {
  name        = "${local.cluster_identifier_clean}-parameter-group-v2"
  family      = "aurora-postgresql16"
  description = "Parameter group for Aurora PostgreSQL with autovacuum enabled"

  parameter {
    name         = "autovacuum"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "autovacuum_naptime"
    value        = "60"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_vacuum_threshold"
    value        = "50"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_analyze_threshold"
    value        = "50"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_vacuum_scale_factor"
    value        = "0.2"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_analyze_scale_factor"
    value        = "0.1"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_vacuum_cost_delay"
    value        = "20"
    apply_method = "immediate"
  }

  parameter {
    name         = "autovacuum_vacuum_cost_limit"
    value        = "200"
    apply_method = "immediate"
  }

  tags = {
    Name = "${local.cluster_identifier_clean}-parameter-group"
  }
}

resource "aws_db_parameter_group" "aurora_db_parameter_group" {
  name        = "${local.cluster_identifier_clean}-db-parameter-group"
  family      = "aurora-postgresql16"
  description = "DB parameter group for Aurora PostgreSQL instances"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  parameter {
    name  = "log_statement"
    value = "none"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = {
    Name = "${local.cluster_identifier_clean}-db-parameter-group"
  }
}