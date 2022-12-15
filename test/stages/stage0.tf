terraform {
  clis = {
    source  = "cloud-native-toolkit/clis"
  }
  gitops = {
    source = "cloud-native-toolkit/gitops"
  }
}

provider "gitops" {
  bin_dir  = data.clis_check.clis.bin_dir

  default_host = module.gitea.host
  default_org  = module.gitea.org
  default_username = module.gitea.username
  default_token    = module.gitea.token
  default_ca_cert  = module.gitea.ca_cert
}

provider "clis" {
  alias = "clis2"

  bin_dir = "${path.cwd}/test_bin_dir"
}

data clis_check clis {
}

data clis_check clis2 {
  provider = "clis.clis2"
}

resource local_file bin_dir {
  filename = "${path.cwd}/.bin_dir"

  content = data.clis_check.clis2.bin_dir
}
