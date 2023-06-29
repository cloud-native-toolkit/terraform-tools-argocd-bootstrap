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

variable "tls_secret_name" {
  type        = string
  description = "The name of the secret that contains the ingress tls info"
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
  sensitive   = true
}

variable "git_ca_cert" {
  type        = string
  description = "Base64 encoded ca cert of the gitops repository"
  default     = ""
}

variable "bootstrap_path" {
  type        = string
  description = "The path to the bootstrap config for ArgoCD"
}

variable "bootstrap_branch" {
  type        = string
  description = "The branch of the bootstrap repo"
  default     = "main"
}

variable "sealed_secret_cert" {
  type        = string
  description = "The certificate that will be used to encrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "sealed_secret_private_key" {
  type        = string
  description = "The private key that will be used to decrypt sealed secrets. If not provided, a new one will be generated"
  default     = ""
}

variable "bootstrap_prefix" {
  type        = string
  description = "The prefix used in ArgoCD to bootstrap the application"
  default     = ""
}

variable "create_webhook" {
  type        = bool
  description = "Flag indicating that a webhook should be created in the gitops repo to notify argocd of changes"
  default     = false
}

variable "server_name" {
  type        = string
  description = "The name of the server in the multi-tenant repo"
  default     = "default"
}

variable "delete_app_on_destroy" {
  type        = bool
  description = "Flag indicating that the bootstrap application should be removed from the cluster when the module is destroyed"
  default     = true
}
