packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "python" {
  image  = "python:latest"
  commit = true
  changes = [
    "LABEL version=0.1",
  ]
}

build {
  name = "python-packer"
  sources = [
    "source.docker.python"
  ]

  provisioner "shell" {
    inline = [
      "mkdir -p /home/packer",
    ]
  }

  provisioner "file" {
    source      = "requirements.txt"
    destination = "/home/packer/requirements.txt"
  }

  provisioner "shell" {
    inline = [
      "pip install -r /home/packer/requirements.txt",
    ]
  }

  post-processor "docker-tag" {
    repository = "python-packer"
    tags       = ["python", "latest"]
    only       = ["docker.python"]
  }
}
