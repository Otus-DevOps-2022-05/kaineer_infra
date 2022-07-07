// Network topology
//

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
