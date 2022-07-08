// Database VM instance
//
resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = 2
    memory = var.module_memory 

    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
    user-data = file(var.metadata_file)
  }

}

resource "null_resource" "deploy" {
	count = var.deploy ? 1 : 0

	connection {
    type = "ssh"
    host = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user = "appuser"
    agent = false

    private_key = file(var.private_key_file)
  }

  provisioner "file" {
		content = file("../files/mongodb.conf")
		destination = "/tmp/mongodb.conf"
  }

  provisioner "remote-exec" {
    script = "../files/config_mongodb.sh"
  }
}
