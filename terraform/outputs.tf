output "registry_username" {
  value = "${azurerm_container_registry.akc_registry.admin_username}"
}

output "registry_password" {
  value = "${azurerm_container_registry.akc_registry.admin_password}"
}

output "id" {
  value = "${azurerm_kubernetes_cluster.aks_container.id}"
}

output "storage_account_tier" {
  value = "${azurerm_storage_account.akc_storage.account_tier}"
}
