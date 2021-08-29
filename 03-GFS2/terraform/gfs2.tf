# Network
# Compute Resource

#resource "yandex_compute_disk" "data_disks" {
#  count = 3
#  size = 1
#  name     = "disk-gfs0[count.index]"
#}

resource "yandex_compute_instance" "gfs2-" {
  depends_on = [yandex_vpc_subnet.subnet-1]
  count = 3
  name = "vm-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd83869rbingor0in0ui"
    }
  }

 # secondary_disk {
 #   disk_id = yandex_compute_disk.data_disks[count.index].id
 # }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys =  "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

#resource "yandex_compute_disk" "data_disks" {
#  count = 3
#  name = "disk-gfs-${count.index}"
#  size = 93
#  name     = "disk-gfs01"
#  type     = "network-hdd"
#  zone     = "ru-central1-a"
#  image_id = "ubuntu-16.04-v20180727"
#
#  labels = {
#    environment = "test"
#  }
#}


