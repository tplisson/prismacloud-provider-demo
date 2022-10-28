# Configure the prismacloud provider
terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.2.9"
    }
  }
}
provider "prismacloud" {
  json_config_file = ".prismacloud_auth.json"
}

### Make sure to update the authentication file
# {
#     "url" : "<PRISMA_CLOUD_API_URL",
#     "username" : "<PRISMA_CLOUD_ACCESS_KEY>",
#     "password" : "<PRISMA_CLOUD_ACCESS_SECRET>"
# }


#### Prisma Cloud Custom Policies ####################################

# Configure a custom build policy from a one liner YAML code definition
resource "prismacloud_policy" "build_policy_001" {
  name        = "build_policy_001: custom build policy #1 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name = "build_policy_001: custom build policy #1 created with terraform"
    rule_type = "Config"
    parameters = {
      "savedSearch" : false,
      "withIac" : true,
    }
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : "metadata:\n  name: 'build_policy_002: a custom build policy created with terraform'\n  guidelines: 'build_policy_001: a custom build policy created with terraform'\n  category: general\n  severity: high\nscope:\n  provider: azure\ndefinition:\n  and:\n    - cond_type: attribute\n      resource_types: \n      - azurerm_kubernetes_cluster\n      attribute: azure_active_directory_role_based_access_control\n      operator: exists\n    - cond_type: attribute\n     resource_types: \n      - azurerm_kubernetes_cluster\n      attribute: azure_active_directory_role_based_access_control.azure_rbac_enabled\n      operator: is_true",
      }
    }
  }
}

# Configure a custom build policy from a local file
resource "prismacloud_policy" "build_policy_002" {
  name        = "build_policy_002: custom build policy #2 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  description = "this describes the policy"
  rule {
    name = "build_policy_002: custom build policy #2 created with terraform"
    parameters = {
      "savedSearch" : false,
      "withIac" : true,
    }
    rule_type = "Config"
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("policies/aks/aks001.yaml"),
      }
    }
  }
} 


# Configure a custom run policy from a one liner RQL code definition
resource "prismacloud_policy" "run_policy_001" {
  name        = "run_policy_001: custom run policy #1 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name     = "run_policy_001: custom run policy #1 created with terraform"
    criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-kubernetes-cluster' AND json.rule =  properties.enableRBAC is false"
    parameters = {
      savedSearch = false
      withIac     = false
    }
    rule_type = "Config"
  }
}

# Configure a custom run policy from a local file
resource "prismacloud_policy" "run_policy_002" {
  name        = "run_policy_002: custom run policy #2 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name     = "run_policy_002: custom run policy #2 created with terraform"
    criteria = file("policies/aks/aks001.rql")
    parameters = {
      savedSearch = false
      withIac     = false
    }
    rule_type = "Config"
  }
}

#### Prisma Cloud Account Groups ####################################


# # Account Group for Azure Tenant Root Group -----------------------

# resource "prismacloud_account_group" "tom-az-root-group" {
#   name        = "tom-az-root-group"
#   description = "Tom Plisson's TF lab environment -- Tenant Root Group"
#   account_ids = [
#     "0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-dev::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-prod::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-test::0b46ae8d-00a1-463e-a65d-ff1755227c08"
#   ]
# }

# # Account Group for Azure Management Group: Dev ------------------ 

# resource "prismacloud_account_group" "tom-az-mg-dev" {
#   name        = "tom-az-mg-dev"
#   description = "Tom Plisson's TF lab environment -- MG Dev"
#   account_ids = [
#     "tom-az-mg-dev1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-dev2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-dev3::0b46ae8d-00a1-463e-a65d-ff1755227c08"
#   ]
# }

# resource "prismacloud_account_group" "tom-az-mg-dev1" {
#   name        = "tom-az-mg-dev1"
#   description = "Tom Plisson's TF lab environment -- Nested MG Dev1"
#   account_ids = ["dbae05d8-64f8-4340-899b-aa524be8e2df"]
# }

# resource "prismacloud_account_group" "tom-az-mg-dev2" {
#   name        = "tom-az-mg-dev2"
#   description = "Tom Plisson's TF lab environment -- Nested MG Dev2"
#   account_ids = []
# }

# resource "prismacloud_account_group" "tom-az-mg-dev3" {
#   name        = "tom-az-mg-dev3"
#   description = "Tom Plisson's TF lab environment -- Nested MG Dev3"
#   account_ids = []
# }

# # Account Group for Azure Management Group: Prod ------------------ 

# resource "prismacloud_account_group" "tom-az-mg-prod" {
#   name        = "tom-az-mg-prod"
#   description = "Tom Plisson's TF lab environment -- MG prod"
#   account_ids = [
#     "tom-az-mg-prod1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-prod2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     # "tom-az-mg-prod3::0b46ae8d-00a1-463e-a65d-ff1755227c08" 
#   ]
# }

# resource "prismacloud_account_group" "tom-az-mg-prod1" {
#   name        = "tom-az-mg-prod1"
#   description = "Tom Plisson's TF lab environment -- Nested MG prod1"
#   account_ids = ["08eabb29-a217-40e1-9f0a-61c1935a3014"]
# }

# resource "prismacloud_account_group" "tom-az-mg-prod2" {
#   name        = "tom-az-mg-prod2"
#   description = "Tom Plisson's TF lab environment -- Nested MG prod2"
#   account_ids = []
# }

# # resource "prismacloud_account_group" "tom-az-mg-prod3" {
# #     name = "tom-az-mg-prod3"
# #     description = "Tom Plisson's TF lab environment -- Nested MG prod3"
# #     account_ids = []
# # }

# # Account Group for Azure Management Group: Test ------------------ 

# resource "prismacloud_account_group" "tom-az-mg-test" {
#   name        = "tom-az-mg-test"
#   description = "Tom Plisson's TF lab environment -- MG test"
#   account_ids = [
#     "tom-az-mg-test1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     "tom-az-mg-test2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
#     # "tom-az-mg-test3::0b46ae8d-00a1-463e-a65d-ff1755227c08"
#   ]
# }

# resource "prismacloud_account_group" "tom-az-mg-test1" {
#   name        = "tom-az-mg-test1"
#   description = "Tom Plisson's TF lab environment -- Nested MG test1"
#   account_ids = ["6126b43c-9ec0-4de0-950f-52deecc67c96"]
# }

# resource "prismacloud_account_group" "tom-az-mg-test2" {
#   name        = "tom-az-mg-test2"
#   description = "Tom Plisson's TF lab environment -- Nested MG test2"
#   account_ids = []
# }

# # resource "prismacloud_account_group" "tom-az-mg-test3" {
# #     name = "tom-az-mg-test3"
# #     description = "Tom Plisson's TF lab environment -- Nested MG test3"
# #     account_ids = []
# # }

#### Prisma Cloud User Roles #################################### 

# resource "prismacloud_user_role" "tom-role-az-mg-test-ro" {
#   name              = "tom-role-az-mg-test-ro"
#   description       = "Made by Terraform"
#   role_type         = "Account Group Read Only"
#   account_group_ids = [prismacloud_account_group.tom-az-mg-test.id]
# }

# resource "prismacloud_user_role" "tom-role-az-mg-dev-ro" {
#   name              = "tom-role-az-mg-dev-ro"
#   description       = "Made by Terraform"
#   role_type         = "Account Group Read Only"
#   account_group_ids = [prismacloud_account_group.tom-az-mg-dev.id]
# }


# resource "prismacloud_org_cloud_account" "tom-az-tenant" {
#   # (resource arguments)
# }


# resource "prismacloud_alert_rule" "tom-alert-az-rg-locations" {
#   # (resource arguments)
#   name = "tom-alert-az-rg-locations"
#   target {
#     account_groups = [ "e6093a26-e56f-4717-889f-686a66614273" ]
#   }
#   policies = [ "391d6f3e-fce0-405f-abb7-d99e228c875e" ]
# }

