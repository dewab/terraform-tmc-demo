variable "endpoint" {
  description = "The Tanzu Mission Control service endpoint hostname"
  type        = string
  default     = "<ENDPOINT_HERE>.tmc.cloud.vmware.com"
}

variable "vmw_cloud_api_token" {
  description = "The VMware Cloud Services API Token"
  type        = string
  default     = "<API_TOKEN_HERE>"
}

