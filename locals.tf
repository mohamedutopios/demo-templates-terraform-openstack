# Valeurs calculées / conventions de nommage
locals {
  prefix = "demo1t"

  # Nom complet de chaque ressource : demo1t-vm, demo1t-port, ...
  vm_name    = "${local.prefix}-vm"
  key_name   = "${local.prefix}-key"
  port_name  = "${local.prefix}-port"
  image_name = "${local.prefix}-ubuntu-22.04"

  # Rendu du template cloud-init : chaque clé de la map devient une
  # variable utilisable dans le fichier .tftpl sous la forme ${clé}.
  user_data = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
    vm_name  = local.vm_name
    owner    = var.owner
    message  = var.message
    packages = var.packages
  })
}
