resource "yandex_kubernetes_cluster" "sky_famous_k8s_cluster" {
  name        = "sky-famous-k8s-cluster"
  description = "description"
  folder_id   = var.folder_id_sky_famous
  network_id  = var.vpc_id

  master {
    version = "1.24"
    zonal {
      zone = var.zone_id
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
    tags = "sky-famous"
  }

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"


}

resource "yandex_kubernetes_node_group" "sky_famous_node_group" {
  cluster_id  = yandex_kubernetes_cluster.sky_famous_k8s_cluster.id
  name        = "sky-famous-node-group"
  description = "description"
  version     = "1.24"

  labels = {
    "tags" = "sky-famous"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = ["${yandex_vpc_subnet.sky_famous_subnet_c.id}"]
      security_group_ids = [var.security_group_ids_sky_famous]
    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
    
    metadata = {
      ssh-keys = var.ssh_key
    }
  }

  scale_policy {
    auto_scale {
      initial = 1
      min     = 1
      max     = 2
    }
  }

  allocation_policy {
    location {
      zone = var.zone_id
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }

  }
}

resource "yandex_vpc_subnet" "sky_famous_subnet_c" {
  v4_cidr_blocks = ["10.130.10.0/26"]
  zone           = var.zone_id
  network_id     = var.vpc_id
  folder_id      = var.folder_id_sky_famous
}