locals {
  instances = yandex_compute_instance.app_instance_platform
}

resource "local_file" "create_inventory_file" {

  content = templatefile("./tpl/inventory.tftpl", {
    instances = local.instances
  })

  filename = "./playbooks/inventory"

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u service -i ./playbooks/inventory --private-key ${var.ssh_private_key_path} ./playbooks/install-playbook.yml && ansible-playbook -u web -i ./playbooks/inventory --private-key ${var.ssh_private_key_path} ./playbooks/user-playbook.yml"
  }
}