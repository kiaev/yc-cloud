resource "yandex_iam_service_account" "sa_kube_infra" {
  name        = "sa-kube-infra"
  description = "service account to kubernetes cluster"
}