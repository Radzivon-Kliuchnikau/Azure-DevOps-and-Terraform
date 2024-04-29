terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = "polandcentral"
}

resource "azurerm_container_group" "trcg_test" {
    name = "weathertestapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name
    ip_address_type = "Public"
    dns_name_label = "rklrklweathertestapi"
    os_type = "Linux"
    restart_policy = "OnFailure"

    container {
        name = "weathertestapi"
        image = "rklrkl/weathertestapi"
        cpu = 1
        memory = 1
        ports {
            port = 8080
            protocol = "TCP"
        }
    }
}