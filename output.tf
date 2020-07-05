#module ipa01
output "ssh_host-ipa01" {
  value       = module.ipa01.ssh_host
  description = "ipa01.ssh_host"
}

output "ssh_port-ipa01" {
  value       = module.ipa01.ssh_port
  description = "ipa01.ssh_host"
}

#module ipa02
output "ssh_host-ipa02" {
  value       = module.ipa02.ssh_host
  description = "ipa02.ssh_host"
}

output "ssh_port-ipa02" {
  value       = module.ipa02.ssh_port
  description = "ipa02.ssh_host"
}