resource "yandex_dns_zone" "yc-courses" {
  name        = "yc-courses"
  description = "zone for yandex courses"
  

  zone             = "skyfam.ru."
  public           = true
}

resource "yandex_dns_recordset" "yc-courses-record" {
  zone_id = yandex_dns_zone.yc-courses.id
  name    = "*.infra.skyfam.ru."
  type    = "A"
  ttl     = 600
  data    = ["158.160.28.249"]
}

resource "yandex_dns_recordset" "yc-courses-acme-challenge" {
  zone_id = yandex_dns_zone.yc-courses.id
  name    = "_acme-challenge.infra.skyfam.ru."
  type    = "CNAME"
  ttl     = 600
  data    = ["fpqrfnfc2lqn66mhndog.cm.yandexcloud.net."]
}

