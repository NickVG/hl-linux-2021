# Network
# Compute Resource
# Balancers

resource "yandex_compute_instance" "lb-" {

  depends_on = [yandex_vpc_subnet.subnet-1]
  count = 3
  name = "lb-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd83869rbingor0in0ui"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys =  "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}
