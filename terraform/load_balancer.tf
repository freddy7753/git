resource "yandex_alb_target_group" "web-target-group" {
  name                     = "web-servers-tg"

  target {
    subnet_id              = yandex_vpc_subnet.private_b.id
    ip_address             = yandex_compute_instance.web_1.network_interface.0.ip_address
  }

  target {
    subnet_id              = yandex_vpc_subnet.private_d.id
    ip_address             = yandex_compute_instance.web_2.network_interface.0.ip_address
  }

}

resource "yandex_alb_backend_group" "web-backend-group" {
  name                     = "web-servers-bg"

  http_backend {
    name                   = "web-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.web-target-group.id]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "web-http-router" {
  name                    = "web-servrs-hr"
}

resource "yandex_alb_virtual_host" "web-virtual-host" {
  name                    = "web-vhost"
  http_router_id          = yandex_alb_http_router.web-http-router.id
  route {
    name                  = "route"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.web-backend-group.id
        timeout           = "60s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "web-balancer" {
  name                   = "web-l7-balancer"
  network_id             = yandex_vpc_network.default.id
  security_group_ids     = [yandex_vpc_security_group.balancer_sg.id]
  allocation_policy {
    location {
      zone_id           = "ru-central1-b"
      subnet_id         = yandex_vpc_subnet.private_b.id
    }
  }

  listener {
    name = "http-balancer"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web-http-router.id
      }
    }
  }

}
