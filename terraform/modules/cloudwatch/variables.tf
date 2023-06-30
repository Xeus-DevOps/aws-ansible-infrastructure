variable "env" {
  type = string
  description = "Environment of service working"
}

variable "location" {
  type = string
  description = "Location of serivice cloudwatch monitoring"
}

variable "bucket_domain_name" {
  type = string
  description = "Domain of bucket for cloudwatch log"
}