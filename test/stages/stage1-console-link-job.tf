module "gitops_console_link" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-console-link-job"

  config_repo = module.gitops.config_repo
  config_token = module.gitops.config_token
  config_paths = module.gitops.config_paths
  config_projects = module.gitops.config_projects
  application_repo = module.gitops.application_repo
  application_token = module.gitops.application_token
  application_paths = module.gitops.application_paths
  namespace = module.gitops_namespace.name
}
