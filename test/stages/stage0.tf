terraform {
  required_providers {
    clis = {
      source = "cloud-native-toolkit/clis"
    }
    gitops = {
      source = "cloud-native-toolkit/gitops"
    }
  }
}

provider "gitops" {
  bin_dir = data.clis_check.clis2.bin_dir
}

data clis_check clis2 {
  clis = ["kubectl", "oc", "gitu"]
}

resource local_file bin_dir {
  filename = "${path.cwd}/.bin_dir"

  content = data.clis_check.clis2.bin_dir
}
