variable "token" {
  type = string
  description = "Токен для доступа к облаку"   
  default = ""
}

variable "cloud" {
  type = string
  description = "Идентификатор облака"
  default = ""
}

variable "folder_id" {
  type = string
  description = "Каталог для размещения ресурсов"
  default = ""
}

variable "subnet_id" {
  type = string
  description = "Идентификатор подсети"
  default = ""
}

variable "zone" {
  type = string
  description = "Зона, в которой размещаются подсети"
  default = ""
}

variable "private_key_file" {
  type = string
  description = "Путь к файлу с приватным ключом"
  default = ""
}

variable "reddit_app_image" {
  type = string
  description = "Образ с приложением"
  default = ""
}
