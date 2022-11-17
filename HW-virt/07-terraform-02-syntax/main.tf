terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = "${var.yandex_cloud_id}"
  folder_id                = "${var.yandex_folder_id}"
  zone                     = "ru-central1-a"
}


resource "yandex_compute_instance" "vm" {
  name                     = "vm"
  hostname                 = "nm1.netology.cloud"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 1
  }

  boot_disk {
    initialize_params {
      image_id = "${var.ubuntu}"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "vm:${file("~/.ssh/id_rsa.pub")}"
  }
}
