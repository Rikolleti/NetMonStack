resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "custom" {
  family      = "netmonstack-base"
  folder_id   = var.folder_id
}

resource "yandex_compute_instance" "platform" {
  name        = local.name
  platform_id = var.vm_web_instance_platform
  resources {
    cores         = var.vm_resources["platform"].cores
    memory        = var.vm_resources["platform"].memory
    core_fraction = var.vm_resources["platform"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.custom.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }
}
