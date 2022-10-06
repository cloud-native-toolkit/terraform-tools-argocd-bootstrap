terraform {
  required_providers {
    clis = {
      source  = "cloud-native-toolkit/clis"
    }
  }
}

provider "clis" {
  alias = "clis2"

  bin_dir = "${path.cwd}/test_bin_dir"
}

data clis_check clis2 {
  provider = "clis.clis2"

  clis = ["kubectl", "oc"]
}

resource local_file bin_dir {
  filename = "${path.cwd}/.bin_dir"

  content = data.clis_check.clis2.bin_dir
}
