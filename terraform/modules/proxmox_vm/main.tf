terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

resource "proxmox_vm_qemu" "vm" {
  target_node = var.target_node
  clone       = var.clone
  vmid        = var.vmid
  name        = var.name
  description = var.description
  full_clone  = var.full_clone
  os_type     = var.os_type
  qemu_os     = var.qemu_os
  bios        = var.bios
  agent       = var.agent

  cpu {
    cores     = var.cores
    sockets   = var.sockets
    type      = var.type
    numa      = var.numa
  }

  memory      = var.memory
  scsihw      = var.scsihw

  disks {
    scsi {
      scsi0 {
        disk {
          size       = var.size
          emulatessd = var.emulatessd
          storage    = var.storage # Note to self: Fix this, should differentiate cloudinit and disk
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage    = var.storage
        }
      }
    }
  }

  network {
    id        = var.nic_id
    model     = var.nic_model
    bridge    = var.nic_bridge
    firewall  = var.nic_firewall
    link_down = var.nic_down
    tag       = var.vlan_tag
  }

  # cloud-init config
  ciuser       = var.ci_user
  ciupgrade    = var.ci_upgrade
  sshkeys      = var.ci_ssh_key # Make it a secret
  searchdomain = var.ci_dns_domain
  nameserver   = var.ci_dns_server
  ipconfig0    = (var.ci_ipv4_cidr != null ? "ip=${var.ci_ipv4_cidr},gw=${var.ci_ipv4_gateway}" : "ip=dhcp")

  # Running into some issues, might delete later
  serial {
    id = 0
    type = "socket"
  }
}