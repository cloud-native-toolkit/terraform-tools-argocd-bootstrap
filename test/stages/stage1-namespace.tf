module "gitops_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace"

  config_repo = module.gitops.config_repo
  config_token = module.gitops.config_token
  config_paths = module.gitops.config_paths
  config_projects = module.gitops.config_projects
  application_repo = module.gitops.application_repo
  application_token = module.gitops.application_token
  application_paths = module.gitops.application_paths
  name = var.namespace
  argocd_namespace = module.argocd-bootstrap.argocd_namespace
  argocd_service_account = module.argocd-bootstrap.argocd_service_account
}
