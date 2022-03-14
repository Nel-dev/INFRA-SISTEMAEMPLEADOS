variable "project_name" {
  type        = string
  default     = "sistecredito"
  description = "Project name"
}


variable "location" {
  type        = string
  default     = "Central US"
  description = "Azure project location"
}

variable "environment" {
  type        = string
  default     = "Production"
  description = "App environment"
}

variable "github_token" {
  default = "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"
}