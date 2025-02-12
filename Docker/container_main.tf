terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "ng" {
  name = "nginx:latest"
}


# Create a container
resource "docker_container" "my_con" {
  image = docker_image.ng.image_id
  name  = "my_con"
}

resource "null_resource" "exec" {
  provisioner "local-exec" {
    command = "${path.module}/docker.sh"
    interpreter = [ "/bin/bash" ]
  }
}
