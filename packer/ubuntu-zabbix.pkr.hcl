variable "token" {
  type      = string
  sensitive = true
}

variable "folder_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

source "yandex" "ubuntu-22_04" {
  token               = var.token
  folder_id           = var.folder_id
  subnet_id           = var.subnet_id

  disk_type           = "network-hdd"
  image_description   = "my custom ubuntu for netmonstack"
  image_name          = "ubuntu-2204-lts-oslogin-v20250519"
  source_image_family = "ubuntu-2204-lts-oslogin"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["yandex.ubuntu-22_04"]

  provisioner "file" {
    source      = "scripts/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install.sh",
      "sh /tmp/install.sh"
    ]
  }

}
