module "gitops_console_link" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-console-link-job"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
}
