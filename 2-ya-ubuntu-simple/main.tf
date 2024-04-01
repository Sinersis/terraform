terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  ssh-key = file(var.ssh_key_path)
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}


data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# Имена серверов пишутся только через "-" иначе ошибка.
resource "yandex_compute_instance" "instance_platform" {
  count       = length(var.instance_name)
  name        = var.instance_name[count.index]
  platform_id = "standard-v1"

  # Задаем параметры для виртуальной машины
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  # Инициализируем загрузочный диск
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 30
    }
  }

  # Делаем виртуальную машину прерываемой (на всякий случай)
  scheduling_policy {
    preemptible = true
  }

  # Задаем параметры сети (я взял уже существующую)
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }
}

output "ip" {
  value = tomap({
    for name, vm in yandex_compute_instance.instance_platform : vm.name => vm.network_interface.0.nat_ip_address
  })
}