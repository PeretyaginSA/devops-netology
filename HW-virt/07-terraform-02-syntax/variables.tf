variable "yandex_cloud_id" {
  default = "b1gqp9j991nnrb1vig6s"
}

variable "yandex_folder_id" {
  default = "b1gcr2pbl2bc9gi74p3e"
}

variable "ubuntu" {
  default = "fd807ed79a4kkqfvd1mb"
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.131.0/24"]
}



output "internal_ip_address_vm_yandex_cloud" {
  value = "${yandex_compute_instance.vm.network_interface.0.ip_address}"
}

output "external_ip_address_vm_yandex_cloud" {
  value = "${yandex_compute_instance.vm.network_interface.0.nat_ip_address}"
}
