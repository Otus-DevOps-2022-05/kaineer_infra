// Application VM instance
//

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  labels = {
    tags = "reddit-app"
  }

  resources {
    cores  = 2
    memory = var.module_memory 

    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
    user-data = file(var.metadata_file)
  }

	connection {
    type = "ssh"
    host = self.network_interface.0.nat_ip_address
    user = "appuser"
    agent = false

    private_key = file(var.private_key_file)
  }

  provisioner "file" {
		content = templatefile("../files/puma.service.tftpl", { database_ip = var.database_ip })
    destination = "/tmp/puma.service"
	}

	provisioner "remote-exec" {
		script = "../files/deploy.sh"
  }
}
