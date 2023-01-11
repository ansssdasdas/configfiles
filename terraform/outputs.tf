output "yandex_zone" {
  value       = yandex_compute_instance.vm.zone
  description = "Yandex-zone in which the instance was created"
}

output "yandex_ip_private" {
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
  description = "Private IP on Yandex-cloud"
}

output "yandex_vpc_subnet" {
  value       = yandex_vpc_subnet.subnet.id
  description = "Subnet ID where the instance was created"
}