# Prisma Cloud Terraform Provider Demo

Testing the Terraform provider for the Palo Alto Networks Prisma Cloud platform.
https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest


#### [Provider Configuration](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs)
```hcl
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
```

Configure the authentication parameters in the `.prismacloud_auth.json` file with your API URL and keys:
```json
{
    "url" : "<PRISMA_CLOUD_API_URL",
    "username" : "<PRISMA_CLOUD_ACCESS_KEY>",
    "password" : "<PRISMA_CLOUD_ACCESS_SECRET>"
}
```

#### [Custom Build Policy](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/policy)

##### Configure a custom build policy from a local file
```hcl
resource "prismacloud_policy" "build_policy_001" {
  name        = "build_policy_001: custom build policy #1 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "build_policy_001: custom build policy #1 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = true
    }
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("policies/aks/aks001.yaml")
      }
    }
  }
} 
```

##### Configure a custom build policy from a one liner YAML code definition
```hcl
resource "prismacloud_policy" "build_policy_002" {
  name        = "build_policy_002: custom build policy #2 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "build_policy_002: custom build policy #1 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = true
    }
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : "---\nmetadata:\n  name: \"build_policy_002: a custom build policy created with terraform\"\n  guidelines: \"fix it\"\n  category: general\n  severity: high\nscope:\n  provider: azure\ndefinition:\n  and:\n    - cond_type: attribute\n      resource_types: \n      - azurerm_kubernetes_cluster\n      attribute: azure_active_directory_role_based_access_control\n      operator: exists\n    - cond_type: attribute\n      resource_types: \n      - azurerm_kubernetes_cluster\n      attribute: azure_active_directory_role_based_access_control.azure_rbac_enabled\n      operator: is_true\n",
      }
    }
  }
}
```

#### [Custom Run Policy](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/policy)


##### Configure a custom run policy from a one liner RQL code definition
```hcl
resource "prismacloud_policy" "run_policy_001" {
  name        = "run_policy_001: custom run policy #1 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "run_policy_001: custom run policy #1 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = false
    }
    criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-kubernetes-cluster' AND json.rule =  properties.enableRBAC is false"

  }
}
```

##### Configure a custom run policy from a local file
```hcl
resource "prismacloud_policy" "run_policy_002" {
  name        = "run_policy_002: custom run policy #2 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "run_policy_002: custom run policy #2 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = false
    }
    criteria = file("policies/aks/aks001.rql")
  }
}
```


##### Configure a custom run policy from a saved RQL search
```hcl
resource "prismacloud_policy" "run_policy_003" {
  name        = "run_policy_003: custom run policy #3 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "run_policy_003: custom run policy #3 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = true
      withIac     = false
    }
    criteria = prismacloud_saved_search.run_policy_003.id
  }
}
resource "prismacloud_saved_search" "run_policy_003" {
  name        = "run_policy_003"
  description = "run_policy_003: saved RQL search"
  search_id   = prismacloud_rql_search.run_policy_003.search_id
  query       = prismacloud_rql_search.run_policy_003.query
  time_range {
    relative {
      unit   = prismacloud_rql_search.run_policy_003.time_range.0.relative.0.unit
      amount = prismacloud_rql_search.run_policy_003.time_range.0.relative.0.amount
    }
  }
}
resource "prismacloud_rql_search" "run_policy_003" {
  search_type = "config"
  query       = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-kubernetes-cluster' AND json.rule =  properties.addonProfiles.omsagent.config does not exist or properties.addonProfiles.omsagent.enabled is false"
  time_range {
    relative {
      unit   = "hour"
      amount = 24
    }
  }
}
```

#### [Account Group](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/account_group)

Hierarchy of Azure Managment Groups in lab environment
```
.
tom-az-lab-hierarchy
└── tom-az-root
    ├── tom-az-mg-dev
    │   ├── tom-az-mg-dev1
    │   │   └── tom-az-sub-dev1
    │   ├── tom-az-mg-dev2
    │   │   └── tom-az-sub-dev2
    │   └── tom-az-mg-dev3
    │       └── tom-az-sub-dev3
    ├── tom-az-mg-prod
    │   ├── tom-az-mg-prod1
    │   │   └── tom-az-sub-prod1
    │   ├── tom-az-mg-prod2
    │   │   └── tom-az-sub-prod2
    │   └── tom-az-mg-prod3
    │       └── tom-az-sub-prod3
    └── tom-az-mg-test
        ├── tom-az-mg-test1
        │   └── tom-az-sub-test1
        ├── tom-az-mg-test2
        │   └── tom-az-sub-test2
        └── tom-az-mg-test3
            └── tom-az-sub-test3
```


```hcl
resource "prismacloud_account_group" "tom-az-root-group" {
  name = "tom-az-root-group"
  description = "Tom Plisson's TF lab environment -- Tenant Root Group"
  account_ids = [
      "tom-az-mg-dev::01234567-00aa-9876-a543-210987654321"
      "tom-az-mg-prod::01234567-00aa-9876-a543-210987654321",
      "tom-az-mg-test::01234567-00aa-9876-a543-210987654321"
  ]
}
```

#### [Nested Account Group](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/account_group)
```hcl
resource "prismacloud_account_group" "tom-az-mg-dev" {
    name = "tom-az-mg-dev"
    description = "Tom Plisson's TF lab environment -- MG Dev"
    account_ids = [ 
      "tom-az-mg-dev1::01234567-00aa-9876-a543-210987654321",
      "tom-az-mg-dev2::01234567-00aa-9876-a543-210987654321",
      "tom-az-mg-dev3::01234567-00aa-9876-a543-210987654321",
    ]
}
```

#### [User Role](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/user_role)
```hcl
resource "prismacloud_user_role" "tom-role-az-mg-test" {
  name              = "tom-role-az-mg-test"
  description       = "Made by Terraform"
  role_type         = "Account Group Read Only"
  account_group_ids =  [ "tom-az-mg-test::01234567-00aa-9876-a543-210987654321" ]
}
```

#### [Alert Rule](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/alert_rule)
```hcl
resource "prismacloud_alert_rule" "tom-alert-az-rg-locations" {
  name = "tom-alert-az-rg-locations"
  target {
    account_groups = [ "e6093a26-e56f-4717-889f-686a66614273" ]
  }
  policies = [ "391d6f3e-fce0-405f-abb7-d99e228c875e" ]
}
```