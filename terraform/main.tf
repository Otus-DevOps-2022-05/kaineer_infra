terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.35"
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

resource "yandex_compute_instance" "app" {
  name = "reddit-app-${count.index}"

  count = 2

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
    subnet_id = var.subnet_id
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
