// Write servers into inventory
//   (not the best way, I know)
//
resource "null_resource" "inventory" {
  provisioner "local-exec" {
    command = "echo 'db: ${module.db.external_ip_address_db}\napp: ${module.app.external_ip_address_app}\n' > ../../ansible/servers.yml"
  }
}
