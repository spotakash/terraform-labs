variable "loc" {
  description = "Default Azure Region for My Labs"
  default     = "southeastasia"
}

variable "tags" {
  default = {
    envi   = "tf-lab"
    source = "ak-sub"
  }
}

variable "webapplocs" {
  description = "Default Azure Region for Web apps"
  type        = list(string)
  default     = ["southeastasia", "westus2"]
}