provider "gitops" {
  bin_dir  = data.clis_check.test_clis.bin_dir
}

provider "ibm" {
  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "clis" {
}
