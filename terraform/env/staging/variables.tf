variable "tags" {
  type = object({
    Name = string
    env  = string
  })
  description = "Name of vm"
  default = {
    Name = "Staging-EC2"
    env  = "Staging"
  }
}

variable "postgres_instance_class" {
  type        = string
  description = "Class of the instance DB Postgres"
  default     = "db.t3.micro"
}

variable "postgres_db_family" {
  type        = string
  description = "Which database family to use for DB Postgres"
  default     = "postgres14"
}

variable "env" {
  type        = string
  description = "Environment of database inside"
  default     = "staging"
}

variable "postgres_allocated_storage" {
  type        = number
  description = "Number gb of allocated storage for DB Postgres"
  default     = 20
}

variable "postgres_engine_version" {
  type        = string
  description = "Engine version of DB Postgres"
  default     = "14"
}

variable "location" {
  type        = string
  description = "Location of serivice cloudwatch monitoring"
  default     = "ap-southeast-1a"
}

variable "postgres_username" {
  type = string
  description = "Username for login DB postgres"
  default = "postgres14user"
}
