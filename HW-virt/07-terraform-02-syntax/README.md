# Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."

## Вариант с Yandex.Cloud

ami образ можно создать с помощью `packer`

```tf
root@ubuntu-virtual-machine:/home/ubuntu/HW-terraform-7_2# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm will be created
  + resource "yandex_compute_instance" "vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "nm1.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                vm:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO8Q1wZEPNhjlpmhVTmk4Af982bftOf3Rof4sXr5SyAlOCrMYETDexK4knYsowjyBc3qgp1DZ0v+3j+ojHdWpUVcFyV+xiOHrK8UvezBbFhrgEU8fWLuFAscCMvffC05SwfB0TNLXVolOweb20Y8RjYfHOG1V9lfWKg0gG0oE7KQPs1vZTLC0YOQlfnoqoWh+zSasse/GHvEhq2OhAu6V7M4HPVfeLZq/fdQ+8pc0NSxCaq/7uHant4S+wyAm/bngiLCzPsvNb1IodCxt0V+Cv2cY7GMnUbEhydydeGk802WUTqRx6Tbj9PCtna1tsPJHGqDGIu7NOhMi+PdHBgKS/UEIht0+T4nqqjP1/UgFgyRcCnzuNjuztb/qbhKBGEIfQz/EAH+fDFS7vJ99hOlfR523uQXpnEwuqXoS4zpEDKJBT//CMfZFdCJDP6K0akkhISH/QhcvXZb5pBIMsf6cf/0FUFwfhCTr38HUK6rzUtucUxgRMz0W7cyePHj5yszJdc= root@ubuntu-virtual-machine
            EOT
        }
      + name                      = "vm"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd807ed79a4kkqfvd1mb"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.131.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_vm_yandex_cloud = (known after apply)
  + internal_ip_address_vm_yandex_cloud = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
