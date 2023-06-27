provider "gitops" {
  bin_dir          = data.clis_check.test_clis.bin_dir
  default_host     = module.gitea.host
  default_org      = module.gitea.org
  default_username = module.gitea.username
  default_token    = module.gitea.token
  default_ca_cert  = module.gitea.ca_cert
}

provider "ibm" {
  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
}

provider "clis" {
}
