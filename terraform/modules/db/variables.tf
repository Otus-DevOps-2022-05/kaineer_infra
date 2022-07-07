// variable public_key_path {
//   type = string
//   description = "Path to the public key used for ssh access"
// }

variable "db_disk_image" {
  // type = string
  description = "Disk image for reddit db"
  default = "reddit-db"
}

variable subnet_id {
  type = string
  description = "Subnets for modules"
}

variable metadata_file {
  type = string
  description = "Path to metadata file"
}

variable module_name {
  type = string
  description = "Attempt to set module name"
}

variable private_key_file {
  type = string
  description = "Private key path"
}

variable module_memory {
  type = number
  description = "Gigabytes per VM"
  default = 1
}

variable deploy {
  type = bool
  description = "Do deploy steps"
  default = false
}
