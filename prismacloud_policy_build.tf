
resource "prismacloud_policy" "build_policy_001" {
  name        = "build_policy_001: a custom build policy created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  rule {
    name = "build_policy_001: a custom build policy created with terraform"
    parameters = {
      "savedSearch" : false,
      "withIac" : true,
    }
    rule_type = "Config"
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("build_policy.yaml"),
      }
    }
  }
}

# resource "prismacloud_policy" "tf_policy_code" {
#   name        = "build_policy_002: another custom build policy created with terraform"
#   policy_type = "config"
#   cloud_type  = "aws"
#   severity    = "high"
#   description = "this describes the policy"
#   rule {
#     name = "build_policy_002: another custom build policy created with terraform"
#     parameters = {
#       "savedSearch" : false,
#       "withIac" : true,
#     }
#     rule_type = "Config"
#     children {
#       type           = "build"
#       recommendation = "fix it"
#       metadata = {
#         "code" : file("aws_build_policy.yaml"),
#       }
#     }
#   }
# } 
