data "yandex_resourcemanager_folder" "sky-famous-catalog" {
    name = "sky-famous-catalog"
}

data "yandex_iam_service_account" "kube-infra" {
  name        = "kube-infra"
}

data "yandex_vpc_security_group" "yc_k8s_ansible" {
  name        = "yc-k8s-ansible"
}

data "yandex_vpc_subnet" "default_ru_central1_a" {
  name        = "default-ru-central1-a"
}

data "yandex_vpc_subnet" "default_ru_central1_b" {
  name        = "default-ru-central1-b"
}

data "yandex_vpc_subnet" "default_ru_central1_c" {
  name        = "default-ru-central1-c"
}

resource "yandex_compute_instance" "skyfam_k8s_ans_master" {
    name        = "skyfam-k8s-ans-master"
    description = "skyfam-k8s-ans-master"
    folder_id   = data.yandex_resourcemanager_folder.sky-famous-catalog.id
    network_acceleration_type = "standard"
    platform_id               = "standard-v1"
    hostname                  = "skyfam-k8s-ans-master"
    allow_stopping_for_update = true
    metadata = {
        ssh-keys = "ubuntu:${file("./id_ed25519.pub")}"
    }
    service_account_id        = data.yandex_iam_service_account.kube-infra.id
    zone                      = "ru-central1-a"
    
    resources {
        core_fraction = 100
        cores  = 2
        memory = 2
    }
    
    boot_disk {
        auto_delete = true
        initialize_params {
        name =     "ubuntu-custom"
        type       = "network-hdd"
        image_id   = "fd83vr5gu3tiq9cd772s"
        size       = 12
        }
    }

    network_interface {
        security_group_ids = [data.yandex_vpc_security_group.yc_k8s_ansible.id]
        subnet_id          = data.yandex_vpc_subnet.default_ru_central1_a.id
        nat                = true
        ipv4               = true
    }

    scheduling_policy {
        preemptible = true
    }
}


# resource "yandex_compute_instance" "skyfam_k8s_ans_worker_b" {
#     name        = "skyfam-k8s-ans-worker-b"
#     description = "skyfam-k8s-ans-worker-b"
#     folder_id   = data.yandex_resourcemanager_folder.sky-famous-catalog.id
#     network_acceleration_type = "standard"
#     platform_id               = "standard-v1"
#     hostname                  = "skyfam-k8s-ans-worker-b"
#     allow_stopping_for_update = true
#     metadata = {
#         ssh-keys = "ubuntu:${file("./id_ed25519.pub")}"
#     }
#     service_account_id        = data.yandex_iam_service_account.kube-infra.id
#     zone                      = "ru-central1-b"
    
#     resources {
#         core_fraction = 100
#         cores  = 2
#         memory = 2
#     }
    
#     boot_disk {
#         auto_delete = true
#         initialize_params {
#         type       = "network-hdd"
#         image_id   = "fd83vr5gu3tiq9cd772s"
#         size       = 12
#         }
#     }

#     network_interface {
#         security_group_ids = [data.yandex_vpc_security_group.yc_k8s_ansible.id]
#         subnet_id          = data.yandex_vpc_subnet.default_ru_central1_b.id
#         nat                = true
#         ipv4               = true
#     }

#     scheduling_policy {
#         preemptible = true
#     }
# }

# resource "yandex_compute_instance" "skyfam_k8s_ans_worker_c" {
#     name        = "skyfam-k8s-ans-worker-c"
#     description = "skyfam-k8s-ans-worker-c"
#     folder_id   = data.yandex_resourcemanager_folder.sky-famous-catalog.id
#     network_acceleration_type = "standard"
#     platform_id               = "standard-v1"
#     hostname                  = "skyfam-k8s-ans-worker-c"
#     allow_stopping_for_update = true
#     metadata = {
#         ssh-keys = "ubuntu:${file("./id_ed25519.pub")}"
#     }
#     service_account_id        = data.yandex_iam_service_account.kube-infra.id
#     zone                      = "ru-central1-c"
    
#     resources {
#         core_fraction = 100
#         cores  = 2
#         memory = 2
#     }
    
#     boot_disk {
#         auto_delete = true
#         initialize_params {
#         type       = "network-hdd"
#         image_id   = "fd83vr5gu3tiq9cd772s"
#         size       = 12
#         }
#     }

#     network_interface {
#         security_group_ids = [data.yandex_vpc_security_group.yc_k8s_ansible.id]
#         subnet_id          = data.yandex_vpc_subnet.default_ru_central1_c.id
#         nat                = true
#         ipv4               = true
#     }

#     scheduling_policy {
#         preemptible = true
#     }
# }
