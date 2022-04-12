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

resource "docker_container" "con-web" {
  name    = var.v_con_name
  image   = var.v_image
  ports {
    internal = var.v_int_port
    external = var.v_ext_port
  }
}