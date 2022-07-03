terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.75"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud
  folder_id = var.folder_id
  zone      = var.zone
}

module "app" {
  source          = "./modules/app"
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  metadata_file   = var.metadata_file
}

module "db" {
  source          = "./modules/db"
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  metadata_file   = var.metadata_file
}
