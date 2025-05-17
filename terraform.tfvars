## Common Variables ##
company     = "kopicloud"
app_name    = "atlastest"
environment = "dev"

tags = {
  "Application Name"  = "MongoDB Atlas Test"
  "Environment"       = "Dev"
  "Version"           = "1.0"
}

## Azure Authentication ##
azure_subscription_id = "complete-this"
azure_client_id       = "complete-this"
azure_client_secret   = "complete-this"
azure_tenant_id       = "complete-this"

## MongoDB Atlas Authentication ##
mongodb_atlas_public_key  = "complete-this"
mongodb_atlas_private_key = "complete-this"

## MongoDB Atlas Settings ##
atlas_org_id       = "complete-this"
atlas_project_name = "kopiatlas"
atlas_azure_region = "EUROPE_WEST"

atlas_cluster_name          = "kopi-cluster"
atlas_cluster_instance_size = "M10"
atlas_cluster_version       = "8.0"

atlas_ip_whitelist = [
  {
    cidr_block = "200.171.171.0/24"
    comment    = "CIDR block for main office"
  },
  {
    cidr_block = "203.0.113.0/28"
    comment    = "VPN endpoints"
  }
]

atlas_database_users = [
  {
    username = "app-user"
    password = "Y3ll0wPassw0rd"  
    role     = "readWrite"
  },
  {
    username = "web-user"
    password = "Br0wnPassw0rd"  
    role     = "readWrite"
  }  
]
