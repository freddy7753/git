resource "yandex_compute_instance" "web_1" {
  name                      = "web-1"
  hostname                  = "web-1"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

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
    subnet_id = yandex_vpc_subnet.private_b.id
    nat = false
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "web_2" {
  name                      = "web-2"
  hostname                  = "web-2"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-d"

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
    subnet_id = yandex_vpc_subnet.private_d.id
    nat = false
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

