# Déclaration des variables (les valeurs sont dans terraform.tfvars)

variable "cloud_name" {
  description = "Nom de l'entrée dans clouds.yaml"
  type        = string
  default     = "openstack"
}

variable "public_key_path" {
  description = "Chemin de la clé publique SSH injectée dans la VM"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "image_url" {
  description = "URL de l'image cloud Ubuntu (cloud-init inclus) importée dans Glance"
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "flavor_name" {
  description = "Gabarit (vCPU/RAM/disque) de la VM"
  type        = string
  default     = "m1.small"
}

variable "network_name" {
  description = "Réseau privé existant du lab"
  type        = string
  default     = "private"
}

variable "subnet_name" {
  description = "Sous-réseau du réseau privé"
  type        = string
  default     = "private-subnet"
}

variable "secgroup_name" {
  description = "Security group existant (SSH + HTTP + ICMP)"
  type        = string
  default     = "web-ssh-icmp"
}

variable "floating_pool" {
  description = "Réseau externe fournissant les IP flottantes"
  type        = string
  default     = "public"
}

# --- Variables injectées dans le template cloud-init ---

variable "owner" {
  description = "Nom affiché sur la page d'accueil"
  type        = string
}

variable "message" {
  description = "Message affiché sur la page d'accueil"
  type        = string
}

variable "packages" {
  description = "Paquets installés au premier démarrage (boucle for dans le template)"
  type        = list(string)
  default     = ["nginx"]
}
