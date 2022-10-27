# # User Roles -------------------------------------------------- 

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

