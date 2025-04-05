terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

//Configuration the azure Provider
provider "azurerm" {
  subscription_id = "3b70b1bc-e71c-411d-8e1c-5581934e526c"

  features {
    
  }
}

//Create a resource group with a new name
resource "azurerm_resource_group" "example" {
  name = "appservice-resource-group"
  location = "East Us"
}

resource "azurerm_app_service_plan" "example" {
  name = "webapijenkinsrani_plan"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name = "webapijenkinsrani"
  location =  azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version =  "v6.0"
  }
  app_settings = {
    WEBSITE_RUN_FRON_PACKAGE = "1"
  }
}