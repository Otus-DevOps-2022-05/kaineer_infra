provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source = "../modules/vpc"
  zone   = var.zone
}
