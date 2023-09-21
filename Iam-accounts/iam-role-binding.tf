resource "yandex_iam_service_account" "kube_infra" {
  name        = "kube-infra"
  description = "service account to kubernetes cluster"
  folder_id   = yandex_resourcemanager_folder.sky_famous_catalog.id
}

resource "yandex_resourcemanager_folder_iam_binding" "binding_to_editor" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = "editor"

  members = [
    "userAccount:${yandex_iam_service_account.kube_infra.id}"
  ]
}


resource "yandex_iam_service_account" "ingress_controller" {
  name        = "ingress-controller"
  description = "service account to kubernetes cluster"
  folder_id   = yandex_resourcemanager_folder.sky_famous_catalog.id
}

resource "yandex_resourcemanager_folder_iam_binding" "role_alb_editor" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = "alb.editor"

  members = [
    "userAccount:${yandex_iam_service_account.ingress_controller.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "role_vpc_public_admin" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = "vpc.publicAdmin"

  members = [
    "userAccount:${yandex_iam_service_account.ingress_controller.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "role_certificate_manager_certificates_downloader" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = "certificate-manager.certificates.downloader"

  members = [
    "userAccount:${yandex_iam_service_account.ingress_controller.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "role_compute_viewer" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = "compute.viewer"

  members = [
    "userAccount:${yandex_iam_service_account.ingress_controller.id}"
  ]
}