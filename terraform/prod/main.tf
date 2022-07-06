provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud
  folder_id = var.folder_id
  zone      = var.zone
}

module "app" {
  source         = "../modules/app"
  app_disk_image = var.app_disk_image
  subnet_id      = yandex_vpc_subnet.app-subnet.id
  metadata_file  = var.metadata_file
  module_name    = "reddit-app"
  module_memory  = 2
  database_ip    = module.db.external_ip_address_db
  private_key_file = var.private_key_file
}

module "db" {
  source        = "../modules/db"
  db_disk_image = var.db_disk_image
  subnet_id     = yandex_vpc_subnet.app-subnet.id
  metadata_file = var.metadata_file
  module_name    = "reddit-db"
  private_key_file = var.private_key_file
}
