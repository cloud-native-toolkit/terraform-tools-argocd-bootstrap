module "gitops_dashboard" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-dashboard"

  config_repo              = module.gitops.config_repo
  config_token             = module.gitops.config_token
  config_paths             = module.gitops.config_paths
  config_projects          = module.gitops.config_projects
  application_repo         = module.gitops.application_repo
  application_token        = module.gitops.application_token
  application_paths        = module.gitops.application_paths
  namespace                = module.gitops_namespace.name
  cluster_ingress_hostname = module.dev_cluster.platform.ingress
  cluster_type             = module.dev_cluster.platform.type_code
  tls_secret_name          = module.dev_cluster.platform.tls_secret
}
