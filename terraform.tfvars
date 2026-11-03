# Valeurs des variables pour ce déploiement.
# Modifiez ici sans toucher au code (variables.tf contient les défauts).

cloud_name      = "kolla-aio"
public_key_path = "~/.ssh/id_rsa.pub"
flavor_name     = "m1.small"
network_name    = "private"
subnet_name     = "private-subnet"
secgroup_name   = "web-ssh-icmp"
floating_pool   = "public"

# Valeurs reprises dans la page web générée par le template cloud-init
owner    = "Mohamed"
message  = "VM configurée au premier boot par cloud-init, depuis un template Terraform"
packages = ["nginx", "htop", "tree"]
