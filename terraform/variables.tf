###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
}

variable "metadata" {
  type = map(string)
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image_name" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "Image name"
}

variable "vm_web_instance_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform name"
}

variable "landscape" {
  type        = string
  default     = "develop"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}
