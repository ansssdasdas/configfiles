provider "yandex" {
  cloud_id  = var.yc_id
  token = var.yc_token
  folder_id = var.yc_folder_id
  zone = var.yc_zone
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.yc_zone
}

resource "yandex_compute_instance" "vm" {
  name        = "test"
  hostname    = "test"
  description = "test"
  platform_id = "standard-v2"
  zone        = var.yc_zone
  folder_id   = var.yc_folder_id
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type = "network-ssd"
      size = 100
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

