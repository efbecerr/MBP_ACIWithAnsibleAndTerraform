terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
    }
  }
}

provider "aci" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.133.200"
  insecure = true
 }
