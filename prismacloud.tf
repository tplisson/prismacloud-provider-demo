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


# Root --------------------------------------------------
resource "prismacloud_account_group" "tom-az-root-group" {
  name = "tom-az-root-group"
  description = "Tom Plisson's TF lab environment -- Tenant Root Group"
  account_ids = [
      "tom-az-mg-dev::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-prod::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-test::0b46ae8d-00a1-463e-a65d-ff1755227c08"
  ]
}

# Dev MG --------------------------------------------------
resource "prismacloud_account_group" "tom-az-mg-dev" {
    name = "tom-az-mg-dev"
    description = "Tom Plisson's TF lab environment -- MG Dev"
    account_ids = [ 
      "tom-az-mg-dev1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-dev2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-dev3::0b46ae8d-00a1-463e-a65d-ff1755227c08",
    ]
}

resource "prismacloud_account_group" "tom-az-mg-dev1" {
    name = "tom-az-mg-dev1"
    description = "Tom Plisson's TF lab environment -- Nested MG Dev1"
    account_ids = [ "dbae05d8-64f8-4340-899b-aa524be8e2df" ]
}

resource "prismacloud_account_group" "tom-az-mg-dev2" {
    name = "tom-az-mg-dev2"
    description = "Tom Plisson's TF lab environment -- Nested MG Dev2"
    account_ids = []
}

resource "prismacloud_account_group" "tom-az-mg-dev3" {
    name = "tom-az-mg-dev3"
    description = "Tom Plisson's TF lab environment -- Nested MG Dev3"
    account_ids = []
}

# Prod MG -------------------------------------------------- 
resource "prismacloud_account_group" "tom-az-mg-prod" {
    name = "tom-az-mg-prod"
    description = "Tom Plisson's TF lab environment -- MG prod"
    account_ids = [ 
      "tom-az-mg-prod1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-prod2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-prod3::0b46ae8d-00a1-463e-a65d-ff1755227c08",
    ]
}

resource "prismacloud_account_group" "tom-az-mg-prod1" {
    name = "tom-az-mg-prod1"
    description = "Tom Plisson's TF lab environment -- Nested MG prod1"
    account_ids = [ "08eabb29-a217-40e1-9f0a-61c1935a3014" ]
}

resource "prismacloud_account_group" "tom-az-mg-prod2" {
    name = "tom-az-mg-prod2"
    description = "Tom Plisson's TF lab environment -- Nested MG prod2"
    account_ids = []
}

resource "prismacloud_account_group" "tom-az-mg-prod3" {
    name = "tom-az-mg-prod3"
    description = "Tom Plisson's TF lab environment -- Nested MG prod3"
    account_ids = []
}

# Test MG -------------------------------------------------- 
resource "prismacloud_account_group" "tom-az-mg-test" {
    name = "tom-az-mg-test"
    description = "Tom Plisson's TF lab environment -- MG test"
    account_ids = [ 
      "tom-az-mg-test1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-test2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
      "tom-az-mg-test3::0b46ae8d-00a1-463e-a65d-ff1755227c08",
    ]
}

resource "prismacloud_account_group" "tom-az-mg-test1" {
    name = "tom-az-mg-test1"
    description = "Tom Plisson's TF lab environment -- Nested MG test1"
    account_ids = [ "6126b43c-9ec0-4de0-950f-52deecc67c96" ]
}

resource "prismacloud_account_group" "tom-az-mg-test2" {
    name = "tom-az-mg-test2"
    description = "Tom Plisson's TF lab environment -- Nested MG test2"
    account_ids = []
}

resource "prismacloud_account_group" "tom-az-mg-test3" {
    name = "tom-az-mg-test3"
    description = "Tom Plisson's TF lab environment -- Nested MG test3"
    account_ids = []
}


/*
resource "prismacloud_account_group" "tom-tf-lab" {
    name = "tom-tf-lab"
    description = "Tom Plisson's TF lab environment"
    account_ids = [
        "UpWindConsulting_Dev1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
        "UpWindConsulting_Dev2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
        "Dev3::0b46ae8d-00a1-463e-a65d-ff1755227c08",
        "UpWindConsulting_Sales1::0b46ae8d-00a1-463e-a65d-ff1755227c08",
        "UpWindConsulting_Sales2::0b46ae8d-00a1-463e-a65d-ff1755227c08",
        "dbae05d8-64f8-4340-899b-aa524be8e2df",
        "devops-lab-100",
        "gcp-gcs-pso",
        "panw-lab-1",
        "panw-lab2",
        "tom-az-mg-dev1-nested1::0b46ae8d-00a1-463e-a65d-ff1755227c08"
    ]
} 
*/

/*
You can also create account groups from a CSV file using native Terraform
HCL and looping.  Assume you have a CSV file (acc_grps.csv) of account groups that looks like this (with
"||" separating account IDs from each other):

"name","description","accountIDs"
"test_acc_grp1","Made by Terraform","123456789||2315456789"
"test_acc_grp2","Made by Terraform","2315456789"

Here's how you would do this:

locals {
    account_groups = csvdecode(file("acc_grps.csv"))
}

// Now specify the account group resource with a loop like this:
resource "prismacloud_account_group" "tom_lab" {
        for_each = { for inst in local.account_groups : inst.name => inst }

        name = each.value.name
        account_ids = split("||", each.value.accountIDs)
        description = each.value.description
}
*/



resource "prismacloud_user_role" "tom-role-az-ag-ro" {
  name              = "tom-role-az-ag-ro"
  description       = "Made by Terraform"
  role_type         = "Account Group Read Only"
  account_group_ids =  [ "e6093a26-e56f-4717-889f-686a66614273" ]
}

resource "prismacloud_user_role" "tom-role-az-mg-test" {
  name              = "tom-role-az-mg-test"
  description       = "Made by Terraform"
  role_type         = "Account Group Read Only"
  account_group_ids =  [ "tom-az-mg-test::0b46ae8d-00a1-463e-a65d-ff1755227c08" ]
}

# resource "prismacloud_org_cloud_account" "tom-az-tenant" {
#   # (resource arguments)
# }

# resource "prismacloud_policy" "example" {
#   # (resource arguments)
# }

resource "prismacloud_alert_rule" "tom-alert-az-rg-locations" {
  # (resource arguments)
  name = "tom-alert-az-rg-locations"
  target {
    account_groups = [ "e6093a26-e56f-4717-889f-686a66614273" ]
  }
  policies = [ "391d6f3e-fce0-405f-abb7-d99e228c875e" ]
}