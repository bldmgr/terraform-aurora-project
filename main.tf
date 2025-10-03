provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

module "security_groups" {
  source               = "./modules/security-groups"
  vpc_id               = var.vpc_id
  allowed_cidr_blocks  = var.allowed_cidr_blocks
}

module "aurora" {
  source              = "./modules/aurora"
  cluster_identifier  = var.db_name
  engine_version      = var.db_engine_version
  master_username     = var.db_username
  master_password     = var.db_password
  database_name       = var.db_name
  instance_class      = var.db_instance_class
  instance_count      = var.db_instance_count
  subnet_ids          = data.aws_subnets.default.ids
  security_group_ids  = [module.security_groups.aurora_security_group_id]
}

# Data source to get subnets in the VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}