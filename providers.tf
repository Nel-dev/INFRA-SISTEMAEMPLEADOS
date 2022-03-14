provider "azurerm" {
  # Configuration options
  features {}
}

provider "github" {
  GITHUB_TOKEN = "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"
  # Token from env var `GITHUB_TOKEN`
}