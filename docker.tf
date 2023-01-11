resource "docker_image" "cloudflared" {
  name = "cloudflare/cloudflared:latest"
}

resource "docker_container" "homarr-cloudflared" {
  image = docker_image.cloudflared.image_id
  name  = "homarr_cloudflared"
  restart = "always"
  command = ["tunnel", "--no-autoupdate", "run", "--token", "${cloudflare_argo_tunnel.homarr.tunnel_token}"]
}

resource "docker_image" "homarr" {
  name = "ghcr.io/ajnart/homarr:latest"
}

resource "docker_volume" "shared_volume" {
  name = "homarr__app_data"
  driver = "local"
  driver_opts = {
    type = "nfs"
    o = "addr=10.16.32.10,rw,noatime,rsize=8192,wsize=8192,tcp,timeo=14"
    device = ":/volume1/docker/homarr__app_data"
  }
}

resource "docker_container" "homarr" {
  image = docker_image.homarr.image_id
  name  = "homarr"
  restart = "always"
  ports {
    internal = "7575"
    external = "7575"
  }
  volumes {
    container_path = "/app/data/configs"
    volume_name = "homarr__app_data"
  }
}

