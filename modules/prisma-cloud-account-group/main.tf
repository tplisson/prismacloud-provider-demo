resource "prismacloud_account_group" "ag" {
    name = var.acct_group_name
    description = var.acct_group_description
    account_ids = var.acct_ids 
}