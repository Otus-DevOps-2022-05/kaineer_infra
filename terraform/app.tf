// Application VM instance
//
resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  labels = {
    tags = "reddit-app"
  }

  resources {
    cores  = 2
    memory = 1

    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat = true
  }

  // skipped for now
}