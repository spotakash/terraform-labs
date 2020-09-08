variable "loc" {
  description = "Default Azure Region for Akash Labs"
  default     = "southeastasia"
}

variable "tags" {
  default = {
    envi   = "training"
    source = "spotakash"
  }
}