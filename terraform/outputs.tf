output "app_external_ip" {
    value = module.app.external_ip_address_app
}

output "db_external_ip" {
    value = module.db.external_ip_address_db
}
