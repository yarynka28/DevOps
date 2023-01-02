# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "Put your access_key here"
  secret_key = "Put your secret_key here"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "Put your subscription_id"
  client_id       = "Put your client_id here"
  client_secret   = "Put your client_secret here"
  tenant_id       = "Put your tenant_id here"
}
