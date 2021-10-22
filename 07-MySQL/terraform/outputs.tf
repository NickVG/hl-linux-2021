output "balancer_internal_IPs" {
  value = yandex_compute_instance.lb-[*].network_interface.0.ip_address
}

output "web_internal_IPs" {
  value = yandex_compute_instance.web-[*].network_interface.0.ip_address
}

output "balancer_external_IPs" {
  value = yandex_compute_instance.lb-[*].network_interface.0.nat_ip_address
}

output "web_external_IPs" {
  value = yandex_compute_instance.web-[*].network_interface.0.nat_ip_address
}

output "db_internal_IP" {
  value = yandex_compute_instance.db-[*].network_interface.0.ip_address
}

output "db_external_IPs" {
  value = yandex_compute_instance.db-[*].network_interface.0.nat_ip_address
}


### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  db-0-ip = yandex_compute_instance.db-[0].network_interface.0.nat_ip_address
  db-1-ip = yandex_compute_instance.db-[1].network_interface.0.nat_ip_address
  db-2-ip = yandex_compute_instance.db-[2].network_interface.0.nat_ip_address
  web-0-ip = yandex_compute_instance.web-[0].network_interface.0.nat_ip_address
  web-1-ip = yandex_compute_instance.web-[1].network_interface.0.nat_ip_address
  web-2-ip = yandex_compute_instance.web-[2].network_interface.0.nat_ip_address
  lb-0-ip = yandex_compute_instance.lb-[0].network_interface.0.nat_ip_address
  lb-1-ip = yandex_compute_instance.lb-[1].network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory"
}

resource "local_file" "load-balance-hosts-file" {
 content = templatefile("hosts.tmpl",
  {
   db-0-ip = yandex_compute_instance.db-[0].network_interface.0.ip_address
   db-1-ip = yandex_compute_instance.db-[1].network_interface.0.ip_address
   db-2-ip = yandex_compute_instance.db-[2].network_interface.0.ip_address
   web-0-ip = yandex_compute_instance.web-[0].network_interface.0.ip_address
   web-1-ip = yandex_compute_instance.web-[1].network_interface.0.ip_address
   web-2-ip = yandex_compute_instance.web-[2].network_interface.0.ip_address
   lb-0-ip = yandex_compute_instance.lb-[0].network_interface.0.ip_address
   lb-1-ip = yandex_compute_instance.lb-[1].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/lb/files/hosts"
}

resource "local_file" "web-server-hosts-file" {
 content = templatefile("hosts.tmpl",
  {
   db-0-ip = yandex_compute_instance.db-[0].network_interface.0.ip_address
   db-1-ip = yandex_compute_instance.db-[1].network_interface.0.ip_address
   db-2-ip = yandex_compute_instance.db-[2].network_interface.0.ip_address
   web-0-ip = yandex_compute_instance.web-[0].network_interface.0.ip_address
   web-1-ip = yandex_compute_instance.web-[1].network_interface.0.ip_address
   web-2-ip = yandex_compute_instance.web-[2].network_interface.0.ip_address
   lb-0-ip = yandex_compute_instance.lb-[0].network_interface.0.ip_address
   lb-1-ip = yandex_compute_instance.lb-[1].network_interface.0.ip_address
  }
 )
 filename = "../ansible/hosts"
}

resource "local_file" "load-balance-conf" {
 content = templatefile("load_balance1.conf.tmpl",
  {
   web-0-ip = yandex_compute_instance.web-[0].network_interface.0.ip_address
   web-1-ip = yandex_compute_instance.web-[1].network_interface.0.ip_address
   web-2-ip = yandex_compute_instance.web-[2].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/lb/files/load_balance1.conf"
}
