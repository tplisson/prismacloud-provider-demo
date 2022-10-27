terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.2.9"
    }
  }
}
# Configure the prismacloud provider
provider "prismacloud" {
  json_config_file = ".prismacloud_auth.json"
}
