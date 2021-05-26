#-------------------------------
# Common Variables
#-------------------------------
variable "location" {
  type        = string
  default     = "westeurope"
  description = "Name of the default object location."
}

variable "tf_name" {
  type        = string
  default     = "terraform"
  description = "Name of the terraform object."
}

#-------------------------------
# ACR Variables
#-------------------------------

variable "acr_name" {
  type        = string
  default     = "vismaraetacr"
  description = "Name of the Azure Container Registry."
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU name of the container registry."
}

variable "resource_group_name" {
  type        = string
  default     = "acr-resource-group"
  description = "Name of the Azure Container Registry resource group."
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = bool
  default     = false
}

variable "roles" {
  description = "List of roles that should be assigned to sppal."
  type        = list(object({ ppal_id = string, role = string }))
  default     = []
}

variable "content_trust" {
  description = "Enable Docker Content Trust on ACR."
  type        = bool
  default     = false
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}