variable "cluster_identifier" {
  description = "The cluster identifier for Aurora"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cluster_identifier))
    error_message = "Cluster identifier must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "13.6"
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
}

variable "master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "instance_class" {
  description = "The instance class for Aurora instances"
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}