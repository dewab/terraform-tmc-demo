terraform {
  required_providers {
    tanzu-mission-control = {
      source  = "vmware/tanzu-mission-control"
      version = ">= 1.4.4"
    }
  }
}

provider "tanzu-mission-control" {
  endpoint            = var.endpoint
  vmw_cloud_api_token = var.vmw_cloud_api_token
}
