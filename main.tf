
module "openshift_cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd.git?ref=v1.7.5"

  cluster_type        = var.cluster_type
  ingress_subdomain   = var.ingress_subdomain
  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  app_namespace       = "default"
  sealed_secret_cert  = var.sealed_secret_cert
  sealed_secret_private_key = var.sealed_secret_private_key
}

resource null_resource bootstrap_argocd {
  depends_on = [module.openshift_cicd]

  triggers = {
    argocd_host = module.openshift_cicd.argocd_host
    argocd_user = module.openshift_cicd.argocd_username
    argocd_password = module.openshift_cicd.argocd_password
    git_repo = var.gitops_repo_url
    git_token = var.git_token
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/argocd-bootstrap.sh ${self.triggers.argocd_host} ${self.triggers.argocd_user} ${module.openshift_cicd.argocd_namespace} ${self.triggers.git_repo} ${var.git_username} ${var.bootstrap_path}"

    environment = {
      ARGOCD_PASSWORD = self.triggers.argocd_password
      GIT_TOKEN = self.triggers.git_token
    }
  }

  provisioner "local-exec" {
    when = destroy

    command = "${path.module}/scripts/argocd-cleanup.sh ${self.triggers.argocd_host} ${self.triggers.argocd_user} ${self.triggers.git_repo}"

    environment = {
      ARGOCD_PASSWORD = self.triggers.argocd_password
    }
  }
}
