# Démo 1 bis — Première VM configurée par un template cloud-init
# Même socle que 01-premiere-vm (port explicite + IP flottante), mais sur
# une image Ubuntu : au premier boot, cloud-init exécute le user_data rendu
# par templatefile() (locals.tf) → paquets installés, page web générée.
# Aucun SSH n'est nécessaire pour configurer la VM.

# CirrOS ne comprend pas #cloud-config : on importe une image Ubuntu.
resource "openstack_images_image_v2" "ubuntu" {
  name             = local.image_name
  image_source_url = var.image_url
  disk_format      = "qcow2"
  container_format = "bare"
  visibility       = "private"

  properties = {
    os_distro = "ubuntu"
  }
}

resource "openstack_compute_keypair_v2" "demo" {
  name       = local.key_name
  public_key = file(pathexpand(var.public_key_path))
}

resource "openstack_networking_port_v2" "vm" {
  name               = local.port_name
  network_id         = data.openstack_networking_network_v2.private.id
  security_group_ids = [data.openstack_networking_secgroup_v2.web.id]

  fixed_ip {
    subnet_id = data.openstack_networking_subnet_v2.private.id
  }
}

resource "openstack_compute_instance_v2" "vm" {
  name        = local.vm_name
  image_id    = openstack_images_image_v2.ubuntu.id
  flavor_name = var.flavor_name
  key_pair    = openstack_compute_keypair_v2.demo.name

  # Le template rendu est transmis à Nova ; cloud-init le lit au 1er boot.
  # Modifier le template => la VM est recréée (user_data force le remplacement).
  user_data = local.user_data

  network {
    port = openstack_networking_port_v2.vm.id
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool = var.floating_pool
}

resource "openstack_networking_floatingip_associate_v2" "fip" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  port_id     = openstack_networking_port_v2.vm.id
}
