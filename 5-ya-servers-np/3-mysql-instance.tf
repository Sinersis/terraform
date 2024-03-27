resource "yandex_mdb_mysql_cluster" "mysql_instance" {
  environment = "PRODUCTION"
  name        = "new-database-cluster"
  network_id  = var.network_id
  version     = "8.0"
  depends_on = [yandex_compute_instance.app_instance_platform]

  resources {
    resource_preset_id = "m2.small"
    disk_type_id       = "network-ssd"
    disk_size          = 150
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = var.subnet_id
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true
    audit_log                     = true
  }

}