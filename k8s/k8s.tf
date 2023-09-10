resource "yandex_kubernetes_cluster" "sky_famous_k8s_cluster" {
  name        = "sky-famous-k8s-cluster"
  description = "description"
  folder_id   = var.folder_id_sky_famous
  network_id = var.vpc_id

  master {
    version = "1.24"
    zonal {
      zone      = var.zone_id
    }

    public_ip = true

    security_group_ids = [var.security_group_ids_sky_famous]

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }

    
  }

  service_account_id      = var.sa
  node_service_account_id = var.sa

  labels = {
    tags       = "sky-famous"
  }

  release_channel = "RAPID"
  network_policy_provider = "CALICO"

  
}