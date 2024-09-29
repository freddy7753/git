variable "yandex_cloud_token" {
  type = string
  description = "Данная переменная потребует ввести секретный токен в консоли при запуске terraform plan/apply"
}

variable "cloud_id" {
  type = string
  description = "cloud_id"
}

variable "folder_id" {
  type = string
  description = "folder_id"
}

variable "zone" {
  type = string
  description = "zone"
}

variable "service_account_key_file" {
  type = string
  description = "secret key file path"
}

variable "ubuntu_image_2204" {
  type = string
  description = "ubuntu image"
}
