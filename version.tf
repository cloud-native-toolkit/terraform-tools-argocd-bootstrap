terraform {
  required_providers {
    clis = {
      source = "cloud-native-toolkit/clis"
      version = ">= 0.2.0"
    }
    gitops = {
      source = "cloud-native-toolkit/gitops"
      version = ">= 0.14.0"
    }
  }

  required_version = ">= 0.15.0"
}
