variable "pm_api_url" {}
variable "pm_user" {}
variable "pm_password" {}
variable "pm_node" {}

variable "pm_host_sshuser" {}
variable "pm_host_sshpassword" {}

variable "onboot" { default = false }
variable "sockets" { default = 1 }
variable "cores" { default = 1 }
variable "memory" { default = 1024 }
variable "disksize" { default = 10 }
variable "diskreplicate" { default = false }

variable "sshcmd" { type = "list" ["ip addr"] }
