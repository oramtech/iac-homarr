terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.24.0"
    }
  }

  cloud {
    organization = "oramtech"

    workspaces {
      name = "iac-homarr"
    }
  }
}

provider "docker" {
  host     = var.dockertcp_host

  ca_material =  var.dockertcp_ca_material
  cert_material = var.dockertcp_cert_material
  key_material = var.dockertcp_key_material
}