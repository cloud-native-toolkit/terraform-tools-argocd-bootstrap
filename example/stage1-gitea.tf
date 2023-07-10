module "gitea_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-k8s-namespace.git"

  cluster_config_file_path = module.cluster.config_file_path
  name                     = "gitea"
}

module "gitea" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitea"

  cluster_config_file = module.cluster.config_file_path
  ingress_subdomain   = module.cluster.platform.ingress
  tls_secret_name     = module.cluster.platform.tls_secret
  instance_namespace  = module.gitea_namespace.name
  preserve_volumes    = false
}
