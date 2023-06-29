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
