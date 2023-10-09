resource "yandex_vpc_security_group" "yc_security_group" {
  name        = "yc-security-group"
  description = "description for Gitlab security group"
  network_id  = var.vpc_id
  folder_id   = var.folder_id_sky_famous

  labels = {
    tags = "sky-famous"
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol          = "Any"
    description       = "Self security group"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol       = "Any"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }

  egress {
    protocol       = "Any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "yc_k8s_ansible" {
  name        = "yc-k8s-ansible"
  description = "description for K8S-Ansible security group"
  network_id  = var.vpc_id
  folder_id   = var.folder_id_sky_famous

  labels = {
    tags = "sky-famous"
  }

  ingress {
    protocol          = "TCP"
    description       = "Allow SSH protocol from anywhere"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol          = "Any"
    description       = "Self security group"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol       = "Any"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

