# prismacloud-provider-test


Hierarchy of Azure Managment Groups 
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

[Provider Configuration](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs)
```yaml
terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.0.0"
    }
  }
}
# Configure the prismacloud provider
provider "prismacloud" {
    json_config_file = ".prismacloud_auth.json"
}
```

[Account Group](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/account_group)
```yaml
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

[Nested Account Group](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/account_group)
```yaml
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

[User Role](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/user_role)
```yaml
resource "prismacloud_user_role" "tom-role-az-mg-test" {
  name              = "tom-role-az-mg-test"
  description       = "Made by Terraform"
  role_type         = "Account Group Read Only"
  account_group_ids =  [ "tom-az-mg-test::01234567-00aa-9876-a543-210987654321" ]
}
```

[Alert Rule](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs/resources/alert_rule)
```yaml
resource "prismacloud_alert_rule" "tom-alert-az-rg-locations" {
  name = "tom-alert-az-rg-locations"
  target {
    account_groups = [ "e6093a26-e56f-4717-889f-686a66614273" ]
  }
  policies = [ "391d6f3e-fce0-405f-abb7-d99e228c875e" ]
}
```