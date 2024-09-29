output "web_1_ip_address" {
  value = yandex_compute_instance.web_1.network_interface.0.ip_address
}

output "web_2_ip_address" {
  value = yandex_compute_instance.web_2.network_interface.0.ip_address
}

data "yandex_alb_target_group" "my_tg" {
  target_group_id = yandex_alb_target_group.web-target-group.id
}

output "target_group" {
  value = data.yandex_alb_target_group.my_tg.target
}

data "yandex_alb_backend_group" "my_bg" {
  backend_group_id = yandex_alb_backend_group.web-backend-group.id
}

output "backend_group" {
  value = data.yandex_alb_backend_group.my_bg.http_backend
}

data "yandex_alb_http_router" "tf-router" {
  http_router_id = yandex_alb_http_router.web-http-router.id
}

output "tf-router-name" {
  value = data.yandex_alb_http_router.tf-router.name
}

data "yandex_alb_load_balancer" "tf-alb" {
  load_balancer_id = yandex_alb_load_balancer.web-balancer.id
}

output "tf-alb-listener" {
  value = data.yandex_alb_load_balancer.tf-alb.allocation_policy
}
