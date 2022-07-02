terraform {
  required_providers {
    // --- Load yandex cloud provider
    yandex = {
      source = "yandex-cloud/yandex"
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

resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name = "reddit-app-subnet"
  zone = var.zone

  // link to previously defined app-network
  network_id = yandex_vpc_network.app-network.id

  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app-${count.index}"

  allow_stopping_for_update = true

  count = 1

  metadata = {
    user-data = file("./files/metadata.yml")
  }

  resources {
    cores  = 2
    memory = 1

    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.reddit_app_image
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  provisioner "file" {
    source      = "./files/reddit-puma.service"
    destination = "/tmp/reddit-puma.service"
  }

  provisioner "remote-exec" {
    script = "./scripts/deploy.sh"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "appuser"
    agent = false

    private_key = file(var.private_key_file)
  }
}
