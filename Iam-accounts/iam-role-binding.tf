resource "yandex_iam_service_account" "kube_infra" {
  name        = "kube-infra"
  description = "service account to kubernetes cluster"
  folder_id   = yandex_resourcemanager_folder.sky_famous_catalog.id
}

resource "yandex_resourcemanager_folder_iam_binding" "binding_to_editor" {
  folder_id = yandex_resourcemanager_folder.sky_famous_catalog.id

  role = var.role

  members = [
    "userAccount:${yandex_iam_service_account.kube_infra.id}"
  ]
}

