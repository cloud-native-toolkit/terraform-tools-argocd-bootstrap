terraform {
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
    }
    gitops = {
      source = "cloud-native-toolkit/gitops"
    }
    clis = {
      source = "cloud-native-toolkit/clis"
    }
  }
  required_version = ">= 0.13"
}
