variable "app_instance_config" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    platform_id   = string
    preemptible   = bool
    name          = string
    disk_size     = number
  })

  default = {
    cores         = 2
    memory        = 4
    core_fraction = 5
    platform_id   = "standard-v1"
    preemptible   = true
    name          = "app-host"
    disk_size     = 40
  }
}


variable "nginx_instance" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    platform_id   = string
    preemptible   = bool
    name          = string
    disk_size     = number
  })

  default = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    platform_id   = "standard-v1"
    preemptible   = true
    name          = "nginx-host"
    disk_size     = 20
  }
}


variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "token" {
  type        = string
  description = "https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "subnet_id" {
  type        = string
  description = "https://cloud.yandex.ru/ru/docs/vpc/quickstart?from=int-console-help-center-or-nav"
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

