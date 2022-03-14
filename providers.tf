provider "azurerm" {
  # Configuration options
  features {}
}

provider "github" {
  # Token from env var `GITHUB_TOKEN`
  token        = "${var.github_token}"
}