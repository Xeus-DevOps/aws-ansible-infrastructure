module "network" {
  source = "../../modules/network"
}

module "ec2" {
  source = "../../modules/vm"
  subnet_id = module.network.subnet_id
  asg_id = module.network.asg_id
  tags = var.tags
  depends_on = [ module.network ]
}