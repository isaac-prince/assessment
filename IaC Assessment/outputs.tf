output "ELB-ip" {
  value = ""
}
output "db_password" {
 value = module.database.db_config.password
 sensitive = true
}
output "db_username" {
 value = module.database.db_config.user
}

output "lb_dns_name" {
 value = module.autoscaling.lb_dns_name
}