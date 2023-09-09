resource "yandex_iam_service_account" "sky_famous_kube_infra_sa" {
  name        = "sky-famous-kube-infra-sa"
  description = "service account to kubernetes cluster"
}