packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

locals {
  directory = "/home/packer"
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
      "mkdir -p ${local.directory}",
    ]
  }

  provisioner "file" {
    source      = "requirements.txt"
    destination = "${local.directory}/requirements.txt"
  }

  provisioner "shell" {
    inline = [
      "pip install -r ${local.directory}/requirements.txt",
    ]
  }

  post-processor "docker-tag" {
    repository = "python-packer"
    tags       = ["python", "latest"]
    only       = ["docker.python"]
  }
}
