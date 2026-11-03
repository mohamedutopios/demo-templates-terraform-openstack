# Sorties affichées après `terraform apply`

output "ip_privee" {
  description = "IP de la VM sur le réseau privé"
  value       = openstack_networking_port_v2.vm.all_fixed_ips[0]
}

output "ip_flottante" {
  description = "IP joignable depuis la machine hôte"
  value       = openstack_networking_floatingip_v2.fip.address
}

output "url" {
  description = "Page générée par cloud-init (prête après quelques minutes)"
  value       = "http://${openstack_networking_floatingip_v2.fip.address}"
}

output "ssh" {
  description = "Commande de connexion (clé SSH uniquement, pas de mot de passe)"
  value       = "ssh ubuntu@${openstack_networking_floatingip_v2.fip.address}"
}

# Pour voir ce que reçoit réellement la VM : terraform output -raw cloud_init
output "cloud_init" {
  description = "Template cloud-init après rendu par templatefile()"
  value       = local.user_data
}
