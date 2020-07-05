provider "proxmox" {
  pm_parallel       = 1
  pm_tls_insecure   = true
  pm_api_url        = var.pm_api_url
  pm_password       = var.pm_password
  pm_user           = var.pm_user
}

module "ipa01" {
  source            = "./vm"
  vmtemplate = "tmplcentos8v1"
  host = "ipa01"
  ip = "192.168.0.101"
  pm_host_sshuser = var.pm_host_sshuser
  pm_host_sshpassword = var.pm_host_sshpassword
}

module "ipa02" {
  source            = "./vm"
  vmtemplate = "tmplcentos8v1"
  host = "ipa02"
  ip = "192.168.0.102"
  pm_host_sshuser = var.pm_host_sshuser
  pm_host_sshpassword = var.pm_host_sshpassword
}
