resource "azurerm_resource_group" "akc_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource "azurerm_storage_account" "akc_storage" {
  name                     = "pseskubedemo"
  resource_group_name      = "${azurerm_resource_group.akc_rg.name}"
  location                 = "${azurerm_resource_group.akc_rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_container_registry" "akc_registry" {
  name                = "pseskubedemo"
  resource_group_name = "${azurerm_resource_group.akc_rg.name}"
  location            = "${azurerm_resource_group.akc_rg.location}"
  admin_enabled       = true
  sku                 = "Classic"
  storage_account_id  = "${azurerm_storage_account.akc_storage.id}"
}

resource "azurerm_kubernetes_cluster" "aks_container" {
  name       = "pseskubedemo"
  location   = "${var.resource_group_location}"
  dns_prefix = "pseskubedemo"

  resource_group_name = "${azurerm_resource_group.akc_rg.name}"
  kubernetes_version  = "1.11.5"

  linux_profile {
    admin_username = "${var.linux_admin_username}"

    ssh_key {
      key_data = "${var.linux_admin_ssh_publickey_path}"
      key_data = "${file("${var.linux_admin_ssh_publickey_path}")}"
    }
  }

  agent_pool_profile {
    name    = "agentpool"
    count   = "2"
    vm_size = "Standard_B2ms"
    os_type = "Linux"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
}
