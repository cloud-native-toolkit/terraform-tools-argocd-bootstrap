module "gitops_namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  name = var.namespace
  argocd_namespace = module.argocd-bootstrap.argocd_namespace
  argocd_service_account = module.argocd-bootstrap.argocd_service_account
}
