variable "postgres_instance_class" {
  type        = string
  description = "Class of the instance DB Postgres"
}

variable "postgres_db_family" {
  type        = string
  description = "Which database family to use for DB Postgres"
}

variable "env" {
  type        = string
  description = "Environment of database inside"
}

variable "postgres_allocated_storage" {
  type        = number
  description = "Number gb of allocated storage for DB Postgres"
}

variable "postgres_engine_version" {
  type        = string
  description = "Engine version of DB Postgres"
}

variable "postgres_username" {
  type = string
  description = "Username for login DB postgres"
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  type        = number
  default     = 0
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)"
  type        = string
  default     = "gp2"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 60
}

variable "max_allocation_storage" {
  description = "Turn on autoscaling mode, ignore diff to allocation. Must be greater than or equal to alocated_storage or 0 for disable"
  type = number
  default = 0
}