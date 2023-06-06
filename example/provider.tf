provider "ibm" {
  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "clis" {
  bin_dir = "./bin3"
}
