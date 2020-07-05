variable "vmtemplate" {}
variable "host" {}
variable "domain" { default = "yo.virt" }
variable "ip" {}
variable "netmask" { default = "24" }
variable "gw" { default = "192.168.0.1" }
variable "nameserver1" { default = "192.168.0.200" }
variable "nameserver2" { default = "1.1.1.1" }
variable "searchdomain1" { default = "yo.virt" }

variable "pm_host_sshuser" {}
variable "pm_host_sshpassword" {}

variable "vm_sshuser" { default = "root" }
variable "vm_sshpassword" { default = "rootpw" }

variable "cores" { default = 1 }
variable "memory" { default = 1024 }
variable "disksize" { default = 10 }
