terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.56.11:2375/"
}

resource "docker_image" "img-web" {
  name = var.v_image
}