### VM Variables
variable "target_node" {
  description = "The target Proxmox node where the VM will be provisioned (e.g., 'pve')."
  type        = string
}

variable "clone" {
  description = "The name of the Proxmox template to clone (e.g., 'ubuntu-cloudinit')."
  type        = string
}

variable "vmid" {
  description = "The unique identifier for the new VM (e.g., 101)."
  type        = number
}

variable "name" {
  description = "The name or prefix for the virtual machine(s)."
  type        = string
  default     = null
}

variable "description" {
  description = "A brief description for the VM, visible in the Proxmox web UI."
  type        = string
  default     = null
}

variable "full_clone" {
  description = "Specifies whether to create a full clone (true) or a linked clone (false)."
  type        = bool
  default     = true
}

variable "os_type" {
  description = "The guest operating system type for guest agent customization (e.g., 'ubuntu', 'centos')."
  type        = string
  default     = "cloud-init"
}

variable "qemu_os" {
  description = "The QEMU guest OS type. For example, 'l26' is for a Linux 2.6/3.x/4.x kernel."
  type        = string
  default     = "l26"
}

variable "bios" {
  description = "The BIOS implementation for the VM. Options include 'seabios' (default) and 'ovmf' for UEFI."
  type        = string
  default     = "seabios"
}

variable "agent" {
  description = "Specifies if the QEMU guest agent is enabled. Set to 1 for enabled, 0 for disabled."
  type        = number
  default     = 1
}

variable "cores" {
  description = "The number of CPU cores to allocate to the VM."
  type        = number
  default     = 2
}

variable "sockets" {
  description = "The number of CPU sockets to allocate to the VM."
  type        = number
  default     = 1
}

variable "type" {
  description = "The CPU type to emulate. 'host' passes through the host CPU's features."
  type        = string
  default     = "host"
}

variable "numa" {
  description = "Enable or disable NUMA (Non-Uniform Memory Access) architecture emulation."
  type        = bool
  default     = false
}

variable "memory" {
  description = "The amount of memory to allocate to the VM in MiB."
  type        = number
  default     = 2048
}

### Disk Variables
variable "scsihw" {
  description = "The SCSI hardware controller to use for the VM (e.g., 'virtio-scsi-pci')."
  type        = string
  default     = "virtio-scsi-pci"
}

variable "size" {
  description = "The size of the primary disk in GiB (e.g., 12)."
  type        = number
  default     = 12
}

variable "emulatessd" {
  description = "Specifies whether to emulate the disk as an SSD."
  type        = bool
  default     = true
}

variable "storage" {
  description = "The target storage pool for the VM's disk (e.g., 'local-lvm')."
  type        = string
  default     = "local-lvm"
}

### Network Variables
variable "nic_id" {
  description = "The ID of the network interface controller (e.g., 0 for net0)."
  type        = number
  default     = 0
}

variable "nic_model" {
  description = "The model of the network interface controller (e.g., 'virtio')."
  type        = string
  default     = "virtio"
}

variable "nic_bridge" {
  description = "The Proxmox bridge to connect the network interface to (e.g., 'vmbr0')."
  type        = string
  default     = "vmbr0"
}

variable "nic_firewall" {
  description = "Enable or disable the firewall for this network device."
  type        = bool
  default     = true
}

variable "nic_down" {
  description = "Specifies if the network link should be down (true) or up (false) on boot."
  type        = bool
  default     = false
}

variable "vlan_tag" {
  description = "The VLAN tag for the network interface. A value of 0 disables VLAN tagging."
  type        = number
  default     = 0
}

### Cloud-init Variables
variable "ci_user" {
  description = "The username for the default user created by Cloud-Init."
  type        = string
}

variable "ci_upgrade" {
  description = "Specifies whether Cloud-Init should upgrade all packages on the first boot."
  type        = bool
  default     = true
}

variable "ci_ssh_key" {
  description = "The public SSH key to add to the default user's authorized keys."
  type        = string
  default     = null
}

variable "ci_dns_domain" {
  description = "The DNS search domain for the VM. Uses the Proxmox host's settings if null."
  type        = string
  default     = null
}

variable "ci_dns_server" {
  description = "The primary DNS server for the VM. Uses the Proxmox host's settings if null."
  type        = string
  default     = null
}

variable "ci_ipv4_cidr" {
  description = "The static IPv4 address and subnet in CIDR notation (e.g., '192.168.1.2/24'). Uses DHCP if null."
  type        = string
  default     = null
}

variable "ci_ipv4_gateway" {
  description = "The IPv4 gateway address. Required for static IP configuration."
  type        = string
  default     = null
}