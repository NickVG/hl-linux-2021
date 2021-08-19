module "vpc" {
 source                 = "./modules/vpc"
}

module "gfs2" {
 source                 = "./modules/gfs2"
 ssh_pub_key_file       = var.ssh_pub_key_file
 ssh_user               = var.ssh_user
}

module "iscsi-client" {
 source                 = "./modules/iscsi-client"
 ssh_pub_key_file       = var.ssh_pub_key_file
 ssh_user               = var.ssh_user
}
