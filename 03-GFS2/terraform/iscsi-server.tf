#Network
#Compute Resource

resource "yandex_compute_disk" "data_disks" {
  count = 1
  size = 1
#  name     = "disk-gfs0[count.index]"
}

resource "yandex_compute_instance" "iscsi-server" {
  name = "iscsi-server"
  count = 1

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd83869rbingor0in0ui"
    }
  }
  secondary_disk {
    disk_id = yandex_compute_disk.data_disks[count.index].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys =  "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}


