
module "openshift_cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd.git?ref=v2.0.1"

  cluster_type        = var.cluster_type
  ingress_subdomain   = var.ingress_subdomain
  tls_secret_name     = var.tls_secret_name
  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  sealed_secret_cert  = var.sealed_secret_cert
  sealed_secret_private_key = var.sealed_secret_private_key
}

module "bootstrap" {
  source = "github.com/cloud-native-toolkit/terraform-util-gitops-bootstrap.git?ref=v1.6.1"
  depends_on = [
    module.openshift_cicd
  ]

  cluster_config_file = var.cluster_config_file
  gitops_namespace    = module.openshift_cicd.argocd_namespace
  kubeseal_namespace  = module.openshift_cicd.sealed_secrets_namespace
  sealed_secret_cert  = var.sealed_secret_cert
  sealed_secret_private_key = var.sealed_secret_private_key
  gitops_repo_url     = var.gitops_repo_url
  git_username        = var.git_username
  git_token           = var.git_token
  git_ca_cert         = var.git_ca_cert
  bootstrap_path      = var.bootstrap_path
  bootstrap_branch    = var.bootstrap_branch
  server_name         = var.server_name
  prefix              = var.bootstrap_prefix
  create_webhook      = var.create_webhook
  delete_app_on_destroy = var.delete_app_on_destroy
}
