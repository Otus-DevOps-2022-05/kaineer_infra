output "external_ip_instance_1" {
  value = yandex_compute_instance.app[0].network_interface.0.nat_ip_address
}

// output "external_ip_instance_2" {
//   value = yandex_compute_instance.app[1].network_interface.0.nat_ip_address
// }
// 
// output "external_ip_lb" {
//   value = yandex_lb_network_load_balancer.reddit-app-lb.listener.*.external_address_spec[0].*.address[0]
// }
