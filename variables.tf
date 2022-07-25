variable "gcp_project" {
  type = string
}

variable "gcp_service_account_key" {
  type      = string
  sensitive = true
}

variable "boundary_address" {
  type      = string
  sensitive = true
}
