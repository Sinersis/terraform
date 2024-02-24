terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "ubuntu" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "ubuntu" {
  count = length(var.name)
  image = docker_image.ubuntu.image_id
  name  = var.name[count.index]
  must_run = true
  stdin_open = true
  tty = true
}

