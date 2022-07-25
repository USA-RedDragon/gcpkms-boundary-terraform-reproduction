# gcpkms-boundary-terraform-reproduction

Testing `gcpkms` with Boundary Terraform provider, supplying the credentials via a variable to an external datasource.

## Explaination

Without shipping a Google Cloud service account JSON with your Terraform when using the Boundary provider, there is no way to easily provide the credentials to Boundary in text form.
Therefore local file tricks need to be used. This trick in particular is the `external` datasource (<https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source>). This datasource allows a script to be used to bring custom data into Terraform easily. Because this is a datasource, it is refreshed early in the plan process and becomes available to the Boundary provider, unlike `local_file` which has some timing issues that cause either plans or applies to error out.

## Variables

|         Variable          |  Type  |                                                                     Description                                                                       |
| ------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `gcp_project`             | string | Google Cloud project ID                                                                                                                               |
| `gcp_service_account_key` | string | Google Cloud service account credentials appropriate for KMS encryption/decryption. Newlines should be stripped with `cat key.json \| tr -s '\n' ' '` |
| `boundary_address`        | string | URL address, including protocol, of the Boundary API server                                                                                           |
