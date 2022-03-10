data "aws_availability_zones" "available" {}

module "vpc" {
  source                           = "terraform-aws-modules/vpc/aws"
  version                          = "2.64.0"
  name                             = "${var.namespace}-vpc"
  cidr                             = "10.0.0.0/16"
  azs                              = data.aws_availability_zones.available.names
  private_subnets                  = ["10.0.2.0/24"]
  public_subnets                   = ["10.0.101.0/24"]
  database_subnets                 = ["10.0.21.0/24"]
  create_database_subnet_group     = true
  enable_nat_gateway               = true
  single_nat_gateway               = true
}

module "lb_sg" {
 source = "github.com/isaac-prince/terraform-aws-sg-module"
 vpc_id = module.vpc.vpc_id
 ingress_rules = [{
 port = 80
 port = 443
 cidr_blocks = ["0.0.0.0/0"]
 }]
}

module "websvr_sg" {
 source = "github.com/isaac-prince/terraform-aws-sg-module"
 vpc_id = module.vpc.vpc_id
 ingress_rules = [
 {
 port = 22 
 cidr_blocks = ["10.0.0.0/16"] 
 }
 ]
}

module "db_sg" {
 source = "github.com/isaac-prince/terraform-aws-sg-module"
 vpc_id = module.vpc.vpc_id
 ingress_rules = [{
 port = 3306
 security_groups = [module.websvr_sg.security_group.id]
 }]
}
