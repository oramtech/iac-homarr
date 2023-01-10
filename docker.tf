# resource "docker_image" "cloudflared" {
#   name = "cloudflare/cloudflared:latest"
# }


# # Create a container
# resource "docker_container" "cloudflared" {
#   image = docker_image.cloudflared.image_id
#   name  = "cloudflared_tunnel"
#   restart = "always"
#   command = ["tunnel", "--no-autoupdate", "run", "--token", "${var.cloudflared_token}"]
# }


# resource "docker_image" "nginx" {
#   name = "nginx:latest"
# }

# resource "docker_container" "testnginx" {
#   image = docker_image.nginx.image_id
#   name  = "test_nginx_cloudflare_app"
#   restart = "always"
#   ports {
#     internal = "80"
#     external = "8089"
#   }
# }

