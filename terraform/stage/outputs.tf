output "app_external_url" {
  value = "http://${module.app.external_ip_address_app}:9292"
}

output "db_external_ip" {
  value = module.db.external_ip_address_db
}
