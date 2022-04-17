terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.56.11:2375/"
}

resource "docker_network" "bridge_network" {
  name = "app-net"
  driver = "bridge"
}

resource "docker_image" "bgapp-db" {
  name = "shekeriev/bgapp-db:latest"
}

resource "docker_image" "bgapp-web" {
  name = "shekeriev/bgapp-web:latest"
}

resource "docker_container" "db" {
  name = "db"
  image = docker_image.bgapp-db.latest
  networks_advanced {
    name = "app-net"
  }
  env = [ "MYSQL_ROOT_PASSWORD=Password1" ]
}

resource "docker_container" "web" {
  name = "web"
  image = docker_image.bgapp-web.latest
  networks_advanced {
    name = "app-net"
  }
  volumes {
    container_path = "/var/www/html" 
    host_path = "/home/vagrant/bgapp/web"
  }
  ports {
    internal = "80"
    external = "8000"
  }
}




