provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.71.0"
      # version = "~>3.0"
    }
  }
  # terraform version
  required_version = "~>1.3.0"
}
