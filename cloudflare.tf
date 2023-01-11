locals {
  cloudflare_zone_id = "us-east1-b"
}

resource "random_id" "homarr_tunnel_secret" {
  byte_length = 35
}

resource "cloudflare_argo_tunnel" "homarr" {
  account_id = var.cloudflare_account_id
  name       = "homarr-tunnel"
  secret     = random_id.homarr_tunnel_secret.b64_std
}

resource "cloudflare_tunnel_config" "homarr" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_argo_tunnel.homarr.id

  config {    
    ingress_rule {
      hostname = "home.oram.tech"
      service  = "http://10.16.32.10:7575"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "cloudflare_access_application" "homarr" {
  account_id = var.cloudflare_account_id
  name             = "Home"
  domain           = "home.oram.tech"
  session_duration = "1h"
  type = "self_hosted"
}

resource "cloudflare_access_policy" "homarr" {
  account_id = var.cloudflare_account_id
  application_id = cloudflare_access_application.homarr.id
  name           = "Emails Policy"
  precedence     = "2"
  decision       = "allow"

  include {
    email = ["b@oram.co"]
  }
}

resource "cloudflare_record" "homarr" {
  zone_id = var.cloudflare_dns_zone_id
  name    = "home"
  value   = "${cloudflare_argo_tunnel.homarr.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}