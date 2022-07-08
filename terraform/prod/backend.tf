terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "kaineer-state-storage"
    region   = "us-east-1"
    key      = "states/prod.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
