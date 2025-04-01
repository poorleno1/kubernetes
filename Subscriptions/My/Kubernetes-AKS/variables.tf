variable "location" {
  default = "swedencentral"
}

variable "Environment" {
  default = "Development"
}

variable "tags" {
  type = map(string)
  default = {
    Deploy      = "Terraform"
    Application = "AKS"
    Owner       = "Jarek Olechno"
    revision = "3"
  }
  description = "Any tags which should be assigned to the resources in this example"
}
