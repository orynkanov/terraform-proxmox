locals {
  fqdn = "${var.host}.${var.domain}"
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.tmpl")
  vars = {
    host = "${var.host}"
    fqdn = "${local.fqdn}"
    domain = "${var.domain}"
    ip = "${var.ip}"
    netmask = "${var.netmask}"
    gw = "${var.gw}"
    nameserver1 = "${var.nameserver1}"
    nameserver2 = "${var.nameserver2}"
    searchdomain1 = "${var.searchdomain1}"
  }
}

resource "local_file" "cloud_init_user_data_file" {
  content  = data.template_file.user_data.rendered
  filename = "${path.root}/files/user_data-${var.host}.cfg"
}

resource "null_resource" "cloud_init_config_files" {
  connection {
    type     = "ssh"
    user     = var.pm_host_sshuser
    password = var.pm_host_sshpassword
    host     = "hyper01"
  }
  provisioner "file" {
    source      = local_file.cloud_init_user_data_file.filename
    destination = "/var/lib/vz/snippets/user_data-${var.host}.cfg"
  }
}

resource "proxmox_vm_qemu" "vm" {
  depends_on = [null_resource.cloud_init_config_files]

  name              = var.host
  target_node       = "hyper01"

  os_type           = "cloud-init"


  clone             = var.vmtemplate
  full_clone        = true

  onboot            = var.onboot
  agent             = 1
  hotplug           = "disk,network,usb,memory,cpu"
  scsihw            = "virtio-scsi-pci"
  boot              = "c"
  bootdisk          = "scsi0"

  sockets           = var.sockets
  cores             = var.cores
  cpu               = "host"
  numa              = true
  
  memory            = var.memory
  balloon           = var.memory

  disk {
    id              = 0
    size            = var.disksize
    type            = "scsi"
    storage         = "zfs"
    storage_type    = "zfspool"
  }

  network {
    id              = 0
    model           = "virtio"
    bridge          = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
      bootdisk,
      cipassword,
      ciuser,
      ipconfig0,
      nameserver,
      sshkeys,
      searchdomain,
      qemu_os,
    ]
  }

  ipconfig0 = "ip=${var.ip}/${var.netmask},gw=${var.gw}"

  cicustom = "user=local:snippets/user_data-${var.host}.cfg"
}

resource "time_sleep" "wait_2m" {
  depends_on = [proxmox_vm_qemu.vm]

  create_duration = "2m"
}

resource "null_resource" "ssh_exec" {
  depends_on = [time_sleep.wait_2m]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.vm_sshuser
      password = var.vm_sshpassword
      host     = proxmox_vm_qemu.vm.ssh_host
  }
    inline = [
      "ip a"
    ]
  }
}
