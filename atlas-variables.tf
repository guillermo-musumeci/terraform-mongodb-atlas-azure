##########################################
## MongoDB Atlas Deployment - Variables ##
##########################################

## Atlas Organization ID ##
variable "atlas_org_id" {
  type        = string
  description = "Atlas organization id"
}

## Atlas Project Name ##
variable "atlas_project_name" {
  type        = string
  description = "Atlas project name"
}

## Atlas Azure Region ##
variable "atlas_azure_region" {
  description = "Azure region for the MongoDB Atlas cluster"
  type        = string
  default     = "EUROPE_WEST"
}

## Atlas Cluster Name ##
variable "atlas_cluster_name" {
  description = "MongoDB Atlas cluster name"
  type        = string
  default     = "kopi-cluster"
}

## Atlas Cluster Size ##
variable "atlas_cluster_instance_size" {
  description = "MongoDB Atlas cluster instance size"
  type        = string
  default     = "M0"
}

## Atlas Cluster Version ##
variable "atlas_cluster_version" {
  description = "MongoDB version"
  type        = string
  default     = "8.0"
}

## Atlas Cluster Backup ##
variable "atlas_cluster_backup" {
  description = "MongoDB Atlas cluster backup"
  type        = bool
  default     = false
}

## List of IP Addresses to Whitelist ##
variable "atlas_ip_whitelist" {
  description = "List of CIDR blocks (with comments) to whitelist in Atlas"
  type = list(object({
    cidr_block = string
    comment    = string
  }))
  default = []
}

## Atlas Database User List ##
variable "atlas_database_users" {
  description = "List of Atlas database users to create"
  type = list(object({
    username = string
    password = string
    role     = string
  }))
  default = []
  sensitive = true
}