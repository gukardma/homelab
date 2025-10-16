# Terraform Proxmox VM Module

Terraform setup to create and configure VMs.

## Usage Example

This example creates multiple VMs (`k8s-control`, `k8s-worker-01`, `k8s-worker-02`, `k8s-worker-03`).

```hcl
locals {
  vm_names = ["k8s-control", "k8s-worker-01", "k8s-worker-02", "k8s-worker-03"]
}

module "k8s" {
  source = "./modules/proxmox_vm"

  # --- VM Creation ---
  target_node     = "pve01"
  clone           = "ubuntu-cloudinit"
  count           = length(local.vm_names)
  vmid            = 200 + count.index 
  name            = local.vm_names[count.index]

  # --- VM Hardware ---
  cpu             = 2
  memory          = 4096 // 4 GiB
  disk_size       = 32 // 32 GiB

  # --- Cloud-Init Configuration ---
  ci_user         = "ubuntu"
  ci_ipv4_cidr    = "192.168.20.10${count.index}/24"
  ci_ipv4_gateway = "192.168.20.1"
  ci_ssh_key      = "<key>"
}
```

## Disclaimer: Module Scope
This project does not use every parameter available in the Proxmox API via the Terraform provider. For advanced or less common configurations, use the [Telmate/proxmox](https://github.com/Telmate/terraform-provider-proxmox) provider directly or extend this module for your needs.

## Inputs
The following variables were used to configure the virtual machine(s).

### VM Variables

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `target_node` | The target Proxmox node where the VM will be provisioned (e.g., 'pve'). | `string` | **(required)** |
| `clone` | The name of the Proxmox template to clone (e.g., 'ubuntu-cloudinit'). | `string` | **(required)** |
| `vmid` | The unique identifier for the new VM (e.g., 101). | `number` | **(required)** |
| `name` | The name or prefix for the virtual machine(s). | `string` | `null` |
| `description` | A brief description for the VM, visible in the Proxmox web UI. | `string` | `null` |
| `full_clone` | Specifies whether to create a full clone (`true`) or a linked clone (`false`). | `bool` | `true` |
| `os_type` | The guest operating system type for guest agent customization (e.g., 'ubuntu', 'centos'). | `string` | `"cloud-init"` |
| `qemu_os` | The QEMU guest OS type. For example, 'l26' is for a Linux 2.6/3.x/4.x kernel. | `string` | `"l26"` |
| `bios` | The BIOS implementation for the VM. Options include 'seabios' (default) and 'ovmf' for UEFI. | `string` | `"seabios"` |
| `agent` | Specifies if the QEMU guest agent is enabled. Set to `1` for enabled, `0` for disabled. | `number` | `1` |
| `cores` | The number of CPU cores to allocate to the VM. | `number` | `2` |
| `sockets` | The number of CPU sockets to allocate to the VM. | `number` | `1` |
| `type` | The CPU type to emulate. 'host' passes through the host CPU's features. | `string` | `"host"` |
| `numa` | Enable or disable NUMA (Non-Uniform Memory Access) architecture emulation. | `bool` | `false` |
| `memory` | The amount of memory to allocate to the VM in MiB. | `number` | `2048` |

---
### Disk Variables

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `scsihw` | The SCSI hardware controller to use for the VM (e.g., 'virtio-scsi-pci'). | `string` | `"virtio-scsi-pci"` |
| `size` | The size of the primary disk in GiB (e.g., 12). | `number` | `12` |
| `emulatessd` | Specifies whether to emulate the disk as an SSD. | `bool` | `true` |
| `storage` | The target storage pool for the VM's disk (e.g., 'local-lvm'). | `string` | `"local-lvm"` |

---
### Network Variables

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `nic_id` | The ID of the network interface controller (e.g., 0 for net0). | `number` | `0` |
| `nic_model` | The model of the network interface controller (e.g., 'virtio'). | `string` | `"virtio"` |
| `nic_bridge` | The Proxmox bridge to connect the network interface to (e.g., 'vmbr0'). | `string` | `"vmbr0"` |
| `nic_firewall` | Enable or disable the firewall for this network device. | `bool` | `true` |
| `nic_down` | Specifies if the network link should be down (`true`) or up (`false`) on boot. | `bool` | `false` |
| `vlan_tag` | The VLAN tag for the network interface. A value of `0` disables VLAN tagging. | `number` | `0` |

---
### Cloud-init Variables

| Name | Description | Type | Default |
| :--- | :--- | :--- | :--- |
| `ci_user` | The username for the default user created by Cloud-Init. | `string` | **(required)** |
| `ci_upgrade` | Specifies whether Cloud-Init should upgrade all packages on the first boot. | `bool` | `true` |
| `ci_ssh_key` | The public SSH key to add to the default user's authorized keys. | `string` | `null` |
| `ci_dns_domain` | The DNS search domain for the VM. Uses the Proxmox host's settings if `null`. | `string` | `null` |
| `ci_dns_server` | The primary DNS server for the VM. Uses the Proxmox host's settings if `null`. | `string` | `null` |
| `ci_ipv4_cidr` | The static IPv4 address and subnet in CIDR notation (e.g., '192.168.1.2/24'). Uses DHCP if `null`. | `string` | `null` |
| `ci_ipv4_gateway` | The IPv4 gateway address. Required for static IP configuration. | `string` | `null` |