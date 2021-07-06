
module "openshift_cicd" {
  source = "github.com/cloud-native-toolkit/terraform-tools-openshift-cicd.git?ref=v1.3.0"

  cluster_type        = var.cluster_type
  ingress_subdomain   = var.ingress_subdomain
  cluster_config_file = var.cluster_config_file
  olm_namespace       = var.olm_namespace
  operator_namespace  = var.operator_namespace
  app_namespace       = "default"
}

resource null_resource bootstrap_argocd {
  depends_on = [module.openshift_cicd]

  provisioner "local-exec" {
    command = "${path.module}/scripts/argocd-bootstrap.sh ${module.openshift_cicd.argocd_host} ${module.openshift_cicd.argocd_username} ${module.openshift_cicd.argocd_namespace} ${var.gitops_repo_url} ${var.git_username} ${var.bootstrap_path}"

    environment = {
      ARGOCD_PASSWORD = module.openshift_cicd.argocd_password
      GIT_TOKEN = var.git_token
    }
  }
}
