provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud
  folder_id = var.folder_id
  zone      = var.zone
}

module "vpc" {
  source         = "../modules/vpc"
  zone           = var.zone
}

module "app" {
  source         = "../modules/app"
  app_disk_image = var.app_disk_image
  subnet_id      = module.vpc.subnet_id
  metadata_file  = var.metadata_file
  module_name    = "reddit-app"
  deploy         = var.deploy
  database_ip    = module.db.external_ip_address_db
  private_key_file = var.private_key_file
}

module "db" {
  source         = "../modules/db"
  db_disk_image  = var.db_disk_image
  subnet_id      = module.vpc.subnet_id
  metadata_file  = var.metadata_file
  private_key_file = var.private_key_file
  module_name    = "reddit-db"
  deploy         = var.deploy
}
