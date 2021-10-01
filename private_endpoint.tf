locals {

domain    = title(var.info.domain)
subdomain = title(var.info.subdomain)
subproject = "${local.domain}${local.subdomain}"
tags = merge(var.tags, {
    domain = var.info.domain
    subdomain = var.info.subdomain
  })

zone_name = [for subresource in var.subresource_names: 
               lookup(var.zone_info,subresource )]
}

data azurerm_subnet "private_endpoint" {
  
  resource_group_name  = var.private_endpoint_subnet.virtual_network_resource_group_name
  virtual_network_name = var.private_endpoint_subnet.virtual_network_name
  name                 = var.private_endpoint_subnet.virtual_network_subnet_name
}



module naming {
  source  = "github.com/Azure/terraform-azurerm-naming?ref=df6a893e8581ae2078fc40f65d3b9815ef86ac3d"
  // version = "0.1.0"
  suffix  = [ "${title(var.info.domain)}${title(var.info.subdomain)}" ]
}

locals {
  merged_tags = merge(var.tags, {
    domain = var.info.domain
    subdomain = var.info.subdomain
  })
}



resource "azurerm_private_endpoint" "private_endpoint" {
 
for_each = {
   for index, subresource in var.subresource_names: index => subresource
  }
 
  name                = replace(format("%s%s%s%03d",
      substr(
        module.naming.private_endpoint.name, 0, 
        module.naming.private_endpoint.max_length - (4 + length(each.value))
      ),
      title(each.value),
      substr(title(var.info.environment), 0, 1),
      title(var.info.sequence)
    ), "-", ""
  )
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  tags = local.merged_tags

  private_dns_zone_group {
    name                 = var.dns_zone_group_name
    private_dns_zone_ids = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.dns_resource_group_name}/providers/Microsoft.Network/privateDnsZones/${element(local.zone_name,each.key)}"]
  }

  private_service_connection {
    name                           = replace(format("%s%s%s%03d",
      substr(
        module.naming.private_service_connection.name, 0, 
        module.naming.private_service_connection.max_length - (4 + length(each.value))
      ),
      title(each.value),
      substr(title(var.info.environment), 0, 1),
      title(var.info.sequence)
    ), "-", ""
  )
    private_connection_resource_id = var.resource_id
    subresource_names              = [each.value]
    is_manual_connection           = false
  }


}


