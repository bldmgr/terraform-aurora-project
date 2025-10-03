variable "vpc_id" {
  description = "The VPC ID where the security group will be created."
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "The CIDR blocks that are allowed to access the Aurora database."
  type        = list(string)
}

variable "db_security_group_name" {
  description = "The name of the security group for the Aurora database."
  type        = string
  default     = "aurora-db-sg"
}