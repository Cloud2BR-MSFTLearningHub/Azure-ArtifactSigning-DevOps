output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "location" {
  value = data.azurerm_resource_group.rg.location
}

output "artifact_signing_account_id" {
  value = azapi_resource.code_signing_account.id
}

output "artifact_signing_account_name" {
  value = azapi_resource.code_signing_account.name
}

output "artifact_signing_endpoint" {
  value       = local.artifact_signing_endpoint
  description = "Region-specific endpoint used in metadata.json for signing."
}
