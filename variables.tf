variable "project_name" {
  type        = string
  default     = "sistecredito"
  description = "Project name"
}


variable "location" {
  type        = string
  default     = "East US"
  description = "Azure project location"
}

variable "environment" {
  type        = string
  default     = "Production"
  description = "App environment"
}