variable "info" {
  type = object({
    domain      = string
    subdomain   = string
    environment = string
    sequence    = string
  })
}

variable tags {
  type        = map(string)
  description = "Tags object used to tag resources."
}

variable private_endpoint_subnet{
  type = object (
    {
      virtual_network_name                = string
      virtual_network_subnet_name         = string
      virtual_network_resource_group_name = string
    }
  )
}


variable location {}
variable resource_group_name {}
variable resource_id {}

variable subresource_names {
  type = list
}


variable ttl {
  type = number
  default = 10
}

variable dns_resource_group_name {
     type    = string
     default = "hubvnetrg"
}

variable dns_zone_group_name {
  type = string
  default = "default"
}

variable subscription_id {
  type = string
  default = "7e01a526-af7b-4ab3-9aaf-e9e541a7c684"
}


variable zone_info {
  type = map
  default = {
    "registry"          = "privatelink.azurecr.io"
    "sites"             = "privatelink.azurewebsites.net"
    "blob"              = "privatelink.blob.core.windows.net"
    "database"          = "privatelink.database.windows.net"
    "Sql"               = "privatelink.documents.azure.com"
    "file"              = "privatelink.file.core.windows.net"
    "vault"             = "privatelink.vaultcore.azure.net"
    "dfs"               = "privatelink.dfs.core.windows.net"
    "dataFactory"       = "privatelink.datafactory.azure.net"
    "table"             = "privatelink.table.core.windows.net"
    "redisCache"        = "privatelink.redis.cache.windows.net"
    "topic"             = "privatelink.eventgrid.azure.net" 
    "azuremonitor"      = "privatelink.monitor.azure.com"
    "postgresqlServer"  = "privatelink.postgres.database.azure.com"
    "namespace"         = "privatelink.servicebus.windows.net"  

  }
}