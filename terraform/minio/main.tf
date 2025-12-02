module "proxmox_remote_state" {
  source      = "./modules/remote_state"
  name        = "proxmox"
  target_user = "guichard"
}