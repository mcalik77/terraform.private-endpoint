# Azure Private Enpoints 
Terraform module that provisions an private endpoints for choosen resources. 

## Usage
You can include the module by using the following code:

```
# Azure Container Registry

# Resource Group Module
module "rg" {
  source = "git::git@ssh.dev.azure.com:v3/AZBlue/OneAZBlue/terraform.devops.resource-group?ref=v0.0.5"

  info = var.info
  tags = var.tags

  location = var.location
}

# Azure Container Registry Module
module "azure-container-registry" {
  source = "git::git@ssh.dev.azure.com:v3/AZBlue/OneAZBlue/terraform.devops.azure-container-registry?ref=v0.0.2"


  info = var.info
  tags = var.tags
  
  resource_group_name  = module.rg.name
  location             = module.rg.location
  
  sku          = var.sku
  ip_whitelist = var.ip_whitelist
  
  georeplication_locations = var.georeplication_locations
  subnet_whitelist         = var.subnet_whitelist
  private_endpoint         = var.private_endpoint

}
```

## Inputs

The following are the supported inputs for the module.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| info | Info object used to construct naming convention for all resources. | `object` | n/a | yes |
| tags | Tags object used to tag resources. | `object` | n/a | yes |
| resource_group | Name of the resource group where Azure Event Grid Subscription will be deployed. | `string` | n/a | yes |
| location | Location of Azure Event Grid Subscription. | `string` | n/a | yes |
| sku | The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources. | `string` | n/a | no |
| admin_enabled | Specifies whether the admin user is enabled. Defaults to false. | `bool` | false | no |
| georeplication_locations | A list of Azure locations where the container registry should be geo-replicated -  Only supported on new resources with the Premium SKU - The georeplication_locations list cannot contain the location where the Container Registry exists | `string` | [] | no |
| subnet_whitelist | One or more virtual_network blocks as defined below.  Configuring a registry service endpoint is available in the Premium container registry service tier. Microsoft recommend using private endpoints instead of service endpoints in most network scenarios bc there are some limitation using service enpoint. [More info to check](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-vnet) | `List of Object` | n/a | no |
| private_endpoint | Atributes of private endpoints   | `Object` | N/A | no |
| ip_whitelist | White list of ip rules | `string` | N/A | no |