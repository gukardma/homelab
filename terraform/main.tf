resource "proxmox_vm_qemu" "test_resource" {
    target_node = "pve01"
    description = "A test vm"
    clone = "ubuntu-cloudinit"
    tags = "temporary"
    count = 3

    name = "ansible-node-0${count.index + 1}"
    os_type = "cloud-init"
    vmid = 111 + count.index
    agent = 1

    cpu {
        cores = 2
        sockets = 1
        type  = "host"
    }

    memory = 2048
    scsihw = "virtio-scsi-pci"

    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size    = "12G"
                    storage = "local-lvm"
                    emulatessd = true
                }
            }
        }
    }

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
        # tag = 30
    }

    boot = "order=scsi0"

    ipconfig0 = "ip=192.168.20.3${count.index + 1}/24,gw=192.168.20.1"
    nameserver = "192.168.20.1"
    ciupgrade = true

    sshkeys = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEB4c+SggViD5Q9G6jqaePBa1X4GpZgw8UmZronmycQJ pve-vms
    EOF

    serial {
        id = 0
        type = "socket"
    }
    force_recreate_on_change_of = "recreate"
}