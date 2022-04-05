
module "openshift_cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd.git?ref=v1.7.13"

  cluster_type        = var.cluster_type
  ingress_subdomain   = var.ingress_subdomain
  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  sealed_secret_cert  = var.sealed_secret_cert
  sealed_secret_private_key = var.sealed_secret_private_key
}

module "bootstrap" {
  source = "github.com/cloud-native-toolkit/terraform-util-gitops-bootstrap.git?ref=v1.2.10"

  cluster_config_file = var.cluster_config_file
  gitops_namespace    = module.openshift_cicd.argocd_namespace
  kubeseal_namespace  = module.openshift_cicd.sealed_secrets_namespace
  sealed_secret_cert  = var.sealed_secret_cert
  sealed_secret_private_key = var.sealed_secret_private_key
  gitops_repo_url     = var.gitops_repo_url
  git_username        = var.git_username
  git_token           = var.git_token
  bootstrap_path      = var.bootstrap_path
  prefix              = var.bootstrap_prefix
  create_webhook      = var.create_webhook
}
