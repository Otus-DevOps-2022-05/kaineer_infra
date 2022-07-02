variable "token" {
  type = string
  desc = "Токен для доступа к облаку"   
  default = ""
}

variable "cloud" {
  type = string
  desc = "Идентификатор облака"
  default = ""
}

variable "folder_id" {
  type = string
  desc = "Каталог для размещения ресурсов"
  default = ""
}

variable "subnet_id" {
  type = string
  desc = "Идентификатор подсети"
  default = ""
}

variable "zone" {
  type = string
  desc = "Зона, в которой размещаются подсети"
  default = ""
}

variable "private_key_file" {
  type = string
  desc = "Путь к файлу с приватным ключом"
  default = ""
}

variable "reddit_app_image" {
  type = string
  desc = "Образ с приложением"
  default = ""
}
