output "GFS2_internal_IPs" {
  value = yandex_compute_instance.gfs2-[*].network_interface.0.ip_address
}

output "iSCSI_server_internal_IP" {
  value = yandex_compute_instance.iscsi-server[*].network_interface.0.ip_address
}


output "external_ip_address_iscsi_server" {
  value = yandex_compute_instance.iscsi-server[*].network_interface.0.nat_ip_address
}

output "GFS2_external_IPs" {
  value = yandex_compute_instance.gfs2-[*].network_interface.0.nat_ip_address
}

#output "output_vm_1" {
#  value = yandex_compute_instance.gfs2.vm-1.fqdn
#}


### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  iscsi-server-ip = yandex_compute_instance.iscsi-server[0].network_interface.0.nat_ip_address
  gfs2-0-ip = yandex_compute_instance.gfs2-[0].network_interface.0.nat_ip_address
  gfs2-1-ip = yandex_compute_instance.gfs2-[1].network_interface.0.nat_ip_address
  gfs2-2-ip = yandex_compute_instance.gfs2-[2].network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory"
}

resource "local_file" "hosts" {
 content = templatefile("hosts.tmpl",
  {
   iscsi-server-ip = yandex_compute_instance.iscsi-server[0].network_interface.0.ip_address
   gfs2-0-ip = yandex_compute_instance.gfs2-[0].network_interface.0.ip_address
   gfs2-1-ip = yandex_compute_instance.gfs2-[1].network_interface.0.ip_address
   gfs2-2-ip = yandex_compute_instance.gfs2-[2].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/iscsi-client/files/hosts"
}

resource "local_file" "hosts-server" {
 content = templatefile("hosts.tmpl",
  {
   iscsi-server-ip = yandex_compute_instance.iscsi-server[0].network_interface.0.ip_address
   gfs2-0-ip = yandex_compute_instance.gfs2-[0].network_interface.0.ip_address
   gfs2-1-ip = yandex_compute_instance.gfs2-[1].network_interface.0.ip_address
   gfs2-2-ip = yandex_compute_instance.gfs2-[2].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/iscsi-server/files/hosts"
}
