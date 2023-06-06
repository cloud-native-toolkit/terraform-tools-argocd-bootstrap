module "gitea" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitea"

  cluster_config_file = module.cluster.config_file_path
  olm_namespace       = module.olm.olm_namespace
  operator_namespace  = module.olm.target_namespace
  instance_namespace  = module.dev_tools_namespace.name
}
