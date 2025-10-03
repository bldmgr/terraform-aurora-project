variable "vpc_id" {
  description = "The ID of the VPC where the Aurora PostgreSQL database will be created."
  type        = string
}

variable "db_name" {
  description = "The name of the database to create."
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the Aurora database."
  type        = string
  default     = "db.t3.medium"
}

variable "db_engine" {
  description = "The database engine to use."
  type        = string
  default     = "aurora-postgresql"
}

variable "db_engine_version" {
  description = "The version of the database engine."
  type        = string
  default     = "16.4"
}

variable "db_storage" {
  description = "The allocated storage for the database (in GiB)."
  type        = number
  default     = 20
}

variable "db_username" {
  description = "The username for the database."
  type        = string
}

variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
}

variable "allowed_cidr_blocks" {
  description = "The CIDR blocks that are allowed to access the database."
  type        = list(string)
}

variable "db_instance_count" {
  description = "The number of database instances to create (first instance is writer, additional instances are readers)."
  type        = number
  default     = 1
}