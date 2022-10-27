# Configure a custom run policy for Azure 
resource "prismacloud_policy" "run_policy_001" {
  name        = "run_policy_001: a custom run policy created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "low"
  labels      = ["some_tag"]
  description = "this describes the policy"
  rule {
    name     = "run_policy_001: a custom run policy created with terraform"
    criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-kubernetes-cluster' AND json.rule =  properties.enableRBAC is false"
    parameters = {
      savedSearch = "false"
      withIac     = "false"
    }
    rule_type = "Config"
  }
}