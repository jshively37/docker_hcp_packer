# Docker HCP Packer

**WIP**

Repository that will build a simple Python docker container using Packer.

End goal:
 * Docker container will be published to Docker Hub and HCP Packer.
 * Terraform code will run that will reference the Docker container from the registry using the metadata stored in HCP Packer.

### Versions

Packer version: `1.8.4`\
Docker (mac): `Docker version 20.10.17, build 100c701`


### Executing

The following three commands will initialize Packer, use Packer to build the image, and then run the image using Docker.

```shell
packer init .
packer build .
docker run -it python-packer:latest
```
