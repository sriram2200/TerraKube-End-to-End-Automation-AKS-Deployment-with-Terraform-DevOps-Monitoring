
output "kube_config" {
  value = {
    host                   = azurerm_kubernetes_cluster.azaks.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.azaks.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.azaks.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.azaks.kube_config[0].cluster_ca_certificate
  }
}