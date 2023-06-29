variable "postgres_instance_class" {
  type = string
  description = "Class of the instance DB Postgres"
}

variable "postgres_db_family" {
  type = string
  description = "Which database family to use for DB Postgres"
}

variable "env" {
 type = string
 description = "Environment of database inside"
}

variable "postgres_allocated_storage" {
  type = number
  description = "Number gb of allocated storage for DB Postgres"
}

variable "postgres_engine_version" {
  type = string
  description = "Engine version of DB Postgres"
}