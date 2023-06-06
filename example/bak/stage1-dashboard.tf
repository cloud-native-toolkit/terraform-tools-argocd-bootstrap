module "gitops_dashboard" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-dashboard"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace                = module.gitops_namespace.name
  cluster_ingress_hostname = module.cluster.platform.ingress
  cluster_type             = module.cluster.platform.type_code
  tls_secret_name          = module.cluster.platform.tls_secret
}
