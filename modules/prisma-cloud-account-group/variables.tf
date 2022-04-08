variable "acct_group_name" {
  description = "Name of the Cloud Account Group. Must be unique."
  type        = string
}

variable "acct_group_description" {
  description = "Description of the Cloud Account Group."
  type        = string
}

variable "acct_ids" {
  description = "List of Cloud Accounts to assign to this Account Group. For Azure subscriptions, this must be the subscription ID (0b46ae8d-00a1-463e-a65d-ff1755227c08), and for Azure management groups this must be in the format <mg-name>::<id> (MG_Dev1::0b46ae8d-00a1-463e-a65d-ff1755227c08)."
  type        = list(string)
  default     = []
}