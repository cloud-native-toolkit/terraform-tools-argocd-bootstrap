module "gitops_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace.git"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  name = var.namespace
}

module "dev_tools_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace.git"

  cluster_config_file_path = module.cluster.config_file_path
  name                     = var.namespace
}
