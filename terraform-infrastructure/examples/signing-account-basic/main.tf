locals {
  endpoint_by_location = {
    eastus = "https://eus.codesigning.azure.net"
  }

  artifact_signing_endpoint = try(local.endpoint_by_location[lower(replace(var.location, " ", ""))], null)
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

resource "azapi_resource" "code_signing_account" {
  type      = "Microsoft.CodeSigning/codeSigningAccounts@2025-10-13"
  name      = var.code_signing_account_name
  location  = data.azurerm_resource_group.rg.location
  parent_id = data.azurerm_resource_group.rg.id
  tags      = var.tags

  body = {
    properties = {
      sku = {
        name = var.code_signing_sku
      }
    }
  }
}

# Grant the identity running `terraform apply` the data-plane role required to
# complete Identity validation in the Azure portal. Without this, the portal
# reports: "Please ensure you have the 'Artifact Signing Identity Verifier'
# role assigned."
resource "azurerm_role_assignment" "identity_verifier_current" {
  count                = var.assign_identity_verifier_role_to_current ? 1 : 0
  scope                = azapi_resource.code_signing_account.id
  role_definition_name = "Artifact Signing Identity Verifier"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Optional pause to let the role assignment propagate before you attempt
# Identity validation (reduces transient "role not assigned" errors).
resource "time_sleep" "wait_identity_verifier_rbac" {
  count           = var.assign_identity_verifier_role_to_current && var.rbac_propagation_wait_duration != "0s" ? 1 : 0
  depends_on      = [azurerm_role_assignment.identity_verifier_current]
  create_duration = var.rbac_propagation_wait_duration
}

