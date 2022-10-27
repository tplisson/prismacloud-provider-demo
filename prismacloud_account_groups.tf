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

