##################################
## Create MongoDB Atlas Project ##
##################################

## Create a MongoDB Atlas Project ##
resource "mongodbatlas_project" "project" {
  org_id = var.atlas_org_id
  name   = var.atlas_project_name
  tags   = var.tags
}

##################################
## Create MongoDB Atlas Cluster ##
##################################

## Create an Atlas cluster in Azure ##
resource "mongodbatlas_cluster" "cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = var.atlas_cluster_name
  cloud_backup = var.atlas_cluster_backup
  
  auto_scaling_disk_gb_enabled = true
  
  # Provider settings
  provider_name               = "AZURE"
  provider_instance_size_name = var.atlas_cluster_instance_size
  provider_region_name        = var.atlas_azure_region

  # MongoDB version
  mongo_db_major_version = var.atlas_cluster_version
  
  # Advanced configuration
  advanced_configuration {
    javascript_enabled = true
    minimum_enabled_tls_protocol = "TLS1_2"
  }
}

#############################
## Access to Atlas Project ##
#############################

## Whitelist Single IP Address ##
resource "mongodbatlas_project_ip_access_list" "single" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "200.171.171.0/24"
  comment    = "CIDR block for main office"
}

## Get My IP Address ##
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

## Whitelist my current IP address ##
resource "mongodbatlas_project_ip_access_list" "whitelist-myip" {
  project_id = mongodbatlas_project.project.id
  ip_address = chomp(data.http.myip.response_body)
  comment    = "IP Address for home office"
}

## Whitelist Multiple IP Addresses ##
resource "mongodbatlas_project_ip_access_list" "whitelist" {
  for_each   = { for entry in var.atlas_ip_whitelist : entry.cidr_block => entry }
  project_id = mongodbatlas_project.project.id

  cidr_block = each.value.cidr_block
  comment    = each.value.comment
}

#########################
## Create Atlas Users  ##
#########################

## Create a Database Password ##
resource "random_password" "db-user-password" {
  length = 16
  special = true
  override_special = "_%@"
}

## Create a Single Database User ##
resource "mongodbatlas_database_user" "db-user" {
  username   = "galaxy-read"
  password   = random_password.db-user-password.result
  project_id = mongodbatlas_project.project.id

  auth_database_name = "admin"
  roles {
    role_name     = "read"
    database_name = "${var.atlas_project_name}-db"
  }
  
  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

## Create multiple database users ##
resource "mongodbatlas_database_user" "users" {
  count = length(var.atlas_database_users)
  
  username           = var.atlas_database_users[count.index].username
  password           = var.atlas_database_users[count.index].password
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"
  
  roles {
    role_name     = var.atlas_database_users[count.index].role
    database_name = "${var.atlas_project_name}-db"
  }

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}