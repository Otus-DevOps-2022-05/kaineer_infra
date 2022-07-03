// variable public_key_path {
//   type = string
//   description = "Path to the public key used for ssh access"
// }

variable "app_disk_image" {
  type = string
  description = "Disk image for reddit application"
  default = "reddit-app"
}

variable subnet_id {
  type = string
  description = "Subnets for modules"
}

variable metadata_file {
  type = string
  description = "Path to metadata file"
}
