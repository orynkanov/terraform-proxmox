provider "proxmox" {
  pm_parallel       = 1
  pm_tls_insecure   = true
  pm_api_url        = var.pm_api_url
  pm_password       = var.pm_password
  pm_user           = var.pm_user
}

module "salt" {
  source = "./vm"
  pm_node = var.pm_node
  vmtemplate = "tmplcentos8v1"
  host = "salt"
  ip = "192.168.0.111"
  onboot = false
  sockets = 1
  cores = 1
  memory = 1024
  disksize = 10
  diskreplicate = true
  pm_host_sshuser = var.pm_host_sshuser
  pm_host_sshpassword = var.pm_host_sshpassword
  sshcmd = [
    "echo '192.168.0.111 salt' >> /etc/hosts",
    "dnf install -y git",
    "cd /opt",
    "git clone https://github.com/orynkanov/salt-minion-installer.git",
    "/opt/salt-minion-installer/salt-minion-installer.sh",
    "git clone https://github.com/orynkanov/salt-master-installer.git",
    "/opt/salt-master-installer/salt-master-installer.sh"
  ]
}

# module "ansible" {
#   source = "./vm"
#   pm_node = var.pm_node
#   vmtemplate = "tmplcentos8v1"
#   host = "ansible"
#   ip = "192.168.0.112"
#   onboot = false
#   sockets = 1
#   cores = 1
#   memory = 1024
#   disksize = 10
#   diskreplicate = true
#   pm_host_sshuser = var.pm_host_sshuser
#   pm_host_sshpassword = var.pm_host_sshpassword
# }

# module "gitlab" {
#   source = "./vm"
#   pm_node = var.pm_node
#   vmtemplate = "tmplcentos7v1"
#   host = "gitlab"
#   ip = "192.168.0.113"
#   onboot = false
#   sockets = 1
#   cores = 2
#   memory = 4096
#   disksize = 10
#   diskreplicate = true
#   pm_host_sshuser = var.pm_host_sshuser
#   pm_host_sshpassword = var.pm_host_sshpassword
# }

module "ipa01" {
  source = "./vm"
  pm_node = var.pm_node
  vmtemplate = "tmplcentos8v1"
  host = "ipa01"
  ip = "192.168.0.101"
  onboot = false
  sockets = 1
  cores = 2
  memory = 2048
  disksize = 10
  diskreplicate = true
  pm_host_sshuser = var.pm_host_sshuser
  pm_host_sshpassword = var.pm_host_sshpassword
  sshcmd = [
    "echo '192.168.0.111 salt' >> /etc/hosts",
    "dnf install -y git",
    "cd /opt",
    "git clone https://github.com/orynkanov/salt-minion-installer.git",
    "/opt/salt-minion-installer/salt-minion-installer.sh"
  ]
}

module "ipa02" {
  source = "./vm"
  pm_node = var.pm_node
  vmtemplate = "tmplcentos8v1"
  host = "ipa02"
  ip = "192.168.0.102"
  onboot = false
  sockets = 1
  cores = 2
  memory = 2048
  disksize = 10
  diskreplicate = true
  pm_host_sshuser = var.pm_host_sshuser
  pm_host_sshpassword = var.pm_host_sshpassword
  sshcmd = [
    "echo '192.168.0.111 salt' >> /etc/hosts",
    "dnf install -y git",
    "cd /opt",
    "git clone https://github.com/orynkanov/salt-minion-installer.git",
    "/opt/salt-minion-installer/salt-minion-installer.sh"
  ]
}
