resource "yandex_dns_zone" "yc-courses" {
  name        = "yc-courses"
  description = "zone for yandex courses"
  

  zone             = "skyfam.ru."
  public           = true
}

