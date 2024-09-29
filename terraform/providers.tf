terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  folder_id = var.folder_id
  cloud_id = var.cloud_id
  service_account_key_file = var.service_account_key_file
  # zone = "<зона_доступности_по_умолчанию>"
}