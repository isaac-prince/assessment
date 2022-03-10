module "autoscaling" {
    source      = "./modules/autoscaling"
    namespace   = var.namespace
    ssh_keypair = var.ssh_keypair 
    vpc         = module.networking.vpc 
    sg          = module.networking.sg 
    db_config   = module.database.db_config
}

module "database" {
   source    = "./modules/database"
   namespace = var.namespace
   vpc       = module.networking.vpc 
   sg        = module.networking.sg 
}

module "networking" {
   source    = "./modules/networking"
   namespace = var.namespace
}

module "s3backend" {
  source    = "github.com/isaac-prince/aws-s3-bucket-module"
  namespace = var.namespace
}