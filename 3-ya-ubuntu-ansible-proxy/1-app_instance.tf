# Имена серверов пишутся только через "-" иначе ошибка.
resource "yandex_compute_instance" "app_instance_platform" {
  count       = 4
  name        = "${var.app_instance_config.name}-${count.index + 1}"
  platform_id = var.app_instance_config.platform_id

  # Задаем параметры для виртуальной машины
  resources {
    cores         = var.app_instance_config.cores
    memory        = var.app_instance_config.memory
    core_fraction = var.app_instance_config.core_fraction
  }

  # Инициализируем загрузочный диск
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.app_instance_config.disk_size
    }
  }

  # Делаем виртуальную машину прерываемой (на всякий случай)
  scheduling_policy {
    preemptible = var.app_instance_config.preemptible
  }

  # Задаем параметры сети (я взял уже существующую)
  network_interface {
    subnet_id = var.subnet_id
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }
}