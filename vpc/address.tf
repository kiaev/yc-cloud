resource "yandex_vpc_address" "infra-alb" {
  name      = "infra-alb"
  folder_id = var.folder_id_sky_famous

  labels = {
    reserved = "true"
  }


  external_ipv4_address {
    zone_id = "ru-central1-b"
  }
}