output "config" {
  value = {
    id          = module.vm[*].id
    public_ipv4 = module.vm[*].public_ipv4
  }
  # sensitive = true
}