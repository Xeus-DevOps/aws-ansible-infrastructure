module "network" {
  source = "../../modules/network"
  env    = var.env
}

module "iam" {
  source = "../../modules/iam"
  env = var.env
}

module "ec2" {
  source    = "../../modules/vm"
  subnet_id = module.network.subnet_id
  asg_id    = module.network.asg_id
  tags      = var.tags
  vm_iam_instance_profile = module.iam.vm_iam_instance_profile
  depends_on = [
    module.network, module.iam
  ]
}

module "postgres" {
  source                     = "../../modules/postgres"
  postgres_instance_class    = var.postgres_instance_class
  postgres_db_family         = var.postgres_db_family
  postgres_allocated_storage = var.postgres_allocated_storage
  postgres_engine_version    = var.postgres_engine_version
  postgres_username          = var.postgres_username
  env                        = var.env
}

module "bucket" {
  source = "../../modules/bucket"
  env    = var.env
}

module "apigateway" {
  source = "../../modules/apigateway"
  env    = var.env
}

module "cloundfront" {
  source             = "../../modules/cloudfront"
  env                = var.env
  bucket_domain_name = module.bucket.bucket_domain_name
  depends_on = [
    module.bucket
  ]
}

module "cloudwatch" {
  source             = "../../modules/cloudwatch"
  env                = var.env
  bucket_domain_name = module.bucket.bucket_domain_name
  vm_instance_id     = module.ec2.vm_instance_id
  location           = var.location
  depends_on = [
    module.bucket, module.ec2
  ]
}
