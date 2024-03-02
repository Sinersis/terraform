# Имена серверов пишутся только через "-" иначе ошибка.
resource "yandex_compute_instance" "app_instance_platform" {
  count       = 1
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
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-key}"
  }


  provisioner "remote-exec" {
    inline = ["sudo apt update", "echo Done!"]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
      agent       = true
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.ssh_private_key_path} ./ansible/playbook.yml"
  }
}