# Имена серверов пишутся только через "-" иначе ошибка.
resource "yandex_compute_instance" "app_instance_platform" {
  for_each    = var.instances_config
  name        = var.instances_config[each.key].name
  platform_id = var.instances_config[each.key].platform_id

  # Задаем параметры для виртуальной машины
  resources {
    cores         = var.instances_config[each.key].cores
    memory        = var.instances_config[each.key].memory
    core_fraction = var.instances_config[each.key].core_fraction
  }

  # Инициализируем загрузочный диск
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.instances_config[each.key].disk_size
      type     = "network-ssd"
    }
  }

  # Делаем виртуальную машину прерываемой (на всякий случай)
  scheduling_policy {
    preemptible = var.instances_config[each.key].preemptible
  }

  # Задаем параметры сети (я взял уже существующую)
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./config/metadata.txt")}"
  }

  provisioner "remote-exec" {
    inline = ["echo Done!"]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "service"
      private_key = file(var.ssh_private_key_path)
      agent       = true
    }
  }
}