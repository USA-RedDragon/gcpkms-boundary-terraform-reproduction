data "external" "gcpkms" {
  program = ["sh", "${path.module}/magic_gcpkms.sh"]

  query = {
    key      = base64encode(var.gcp_service_account_key)
    filename = "${path.module}/json-key.json"
  }
}

locals {
  boundary_recovery_kms_hcl = <<EOT
kms "gcpckms" {
purpose     = "recovery"
project     = "${var.gcp_project}"
credentials = "${data.external.gcpkms.result.filename}"
region      = "global"
key_ring    = "boundary-keyring"
crypto_key  = "boundary-key"
}
EOT
}

provider "boundary" {
  addr             = var.boundary_address
  recovery_kms_hcl = local.boundary_recovery_kms_hcl
}

resource "boundary_scope" "org" {
  name                     = "organization_one"
  description              = "Test organization"
  scope_id                 = "global"
  auto_create_admin_role   = true
  auto_create_default_role = true
}
