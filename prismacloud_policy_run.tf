# Configure a custom run policy for Azure 
resource "prismacloud_policy" "run_policy_001" {
  policy_type = "config"
  cloud_type  = "azure"
  name        = "run_policy_001: a custom run policy created with terraform"
  severity = "low"
  labels      = ["tplisson", "custom"]
  description = "run_policy_001: a custom run policy created with terraform"
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