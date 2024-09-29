resource "yandex_compute_instance" "elastic_server" {
  name                      = "elasticsearch"
  hostname                  = "elasticsearch"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

  resources {
    cores  = 2
    memory = 3
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_2204
      size     = 10
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_b.id
    nat       = false
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "kibana_server" {
  name                      = "kibana"
  hostname                  = "kibana"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_2204
      size     = 10
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat = true
    security_group_ids = [yandex_vpc_security_group.zabbix_kibana_sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}