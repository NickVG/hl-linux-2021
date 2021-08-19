output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-4.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-4.network_interface.0.nat_ip_address
}
output "output_vm_1" {
  value = yandex_compute_instance.vm-4.fqdn
}


### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  iscsi-client-ip = yandex_compute_instance.vm-4.network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory"
}
