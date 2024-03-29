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

variable "network_id" {
  type = string
  description = "https://cloud.yandex.ru/ru/docs/vpc/quickstart?from=int-console-help-center-or-nav"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

