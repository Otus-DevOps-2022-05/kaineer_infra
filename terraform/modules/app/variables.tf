// variable public_key_path {
//   type = string
//   description = "Path to the public key used for ssh access"
// }

variable "app_disk_image" {
  type = string
  description = "Disk image for reddit application"
  default = "reddit-app"
}

variable "subnet_id" {
  type = string
  description = "Subnets for modules"
}

variable "metadata_file" {
  type = string
  description = "Path to metadata file"
}

variable "module_name" {
  type = string
  description = "Attempt to set module name"
}

variable "module_memory" {
  type = number
  description = "Gigabytes per VM"
  default = 1
}

variable "private_key_file" {
  type = string
  description = "Private key path"
  default = ""
}

variable "database_ip" {
	type = string
	description = "Database instance ip"
	default = ""
}

variable "deploy" {
	type = bool
  description = "Do application deploy"
  default = false
}
