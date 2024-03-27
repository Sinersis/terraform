resource "yandex_compute_instance" "nginx_instance_platform" {
  name        = var.nginx_instance.name
  platform_id = var.nginx_instance.platform_id

  # Задаем параметры для виртуальной машины
  resources {
    cores         = var.nginx_instance.cores
    memory        = var.nginx_instance.memory
    core_fraction = var.nginx_instance.core_fraction
  }

  # Инициализируем загрузочный диск
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.nginx_instance.disk_size
    }
  }

  # Делаем виртуальную машину прерываемой (на всякий случай)
  scheduling_policy {
    preemptible = var.nginx_instance.preemptible
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