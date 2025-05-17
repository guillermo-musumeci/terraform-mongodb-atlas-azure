########################################
## MongoDB Atlas Provider - Variables ##
########################################

variable "mongodb_atlas_public_key" {
  type        = string
  description = "MongoDB Atlas Public Key"
  sensitive   = true
}

variable "mongodb_atlas_private_key" {
  type        = string
  description = "MongoDB Atlas Private Key"
  sensitive   = true
}

################################
## Azure Provider - Variables ##
################################

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

#############################
## Application - Variables ##
#############################

# company name 
variable "company" {
  type        = string
  description = "This variable defines thecompany name used to build resources"
  default     = "kopicloud"
}

# application name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

variable "tags" {
  type        = map(string)
  description = "The collection of tags to be applied against all resources created by the module"
  default     = {}
}
