variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "cluster_type" {
  type        = string
  description = "The type of cluster (openshift or kubernetes)"
}

variable "olm_namespace" {
  type        = string
  description = "Namespace where olm is installed"
}

variable "operator_namespace" {
  type        = string
  description = "Namespace where operators will be installed"
}

variable "ingress_subdomain" {
  type        = string
  description = "The subdomain for ingresses in the cluster"
  default     = ""
}

variable "gitops_repo_url" {
  type        = string
  description = "The GitOps repo url"
}

variable "git_username" {
  type        = string
  description = "The username used to access the GitOps repo"
}

variable "git_token" {
  type        = string
  description = "The token used to access the GitOps repo"
//  sensitive   = true
}

variable "bootstrap_path" {
  type        = string
  description = "The path to the bootstrap config for ArgoCD"
}
