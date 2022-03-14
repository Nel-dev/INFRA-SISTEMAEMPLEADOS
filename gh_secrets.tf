/*
Asignar GITHUB_TOKEN en los variable set de app.terraform.io
*/

data "github_repository" "repo" {
  name = "Nel-dev/INFRA-SISTEMAEMPLEADOS"
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret
resource "github_actions_environment_secret" "username" {
  repository       = data.github_repository.repo.name
  environment       = var.environment
  secret_name       = "REGISTRY_USERNAME"
  plaintext_value   = azurerm_container_registry.acr.admin_username
}

resource "github_actions_environment_secret" "password" {
  repository       = data.github_repository.repo.name
  environment       = var.environment
  secret_name       = "REGISTRY_PASSWORD"
  plaintext_value   = azurerm_container_registry.acr.admin_password
}

resource "github_actions_environment_secret" "url" {
  repository       = data.github_repository.repo.name
  environment       = var.environment
  secret_name       = "REGISTRY_URL"
  plaintext_value   = azurerm_container_registry.acr.login_server
}