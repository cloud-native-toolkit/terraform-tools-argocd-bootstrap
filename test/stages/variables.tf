
variable "ibmcloud_api_key" {
  type        = string
  description = "The api key for IBM Cloud access"
}

variable "namespace" {
  type        = string
  description = "Namespace for tools"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = ""
}

variable "cluster_exists" {
  type        = string
  description = "Flag indicating if the cluster already exists (true or false)"
  default     = "true"
}

variable "name_prefix" {
  type        = string
  description = "Prefix name that should be used for the cluster and services. If not provided then resource_group_name will be used"
  default     = ""
}

variable "vpc_cluster" {
  type        = bool
  description = "Flag indicating that this is a vpc cluster"
  default     = false
}

variable "git_token" {
  type        = string
  description = "Git token"
}

variable "git_username" {
  type        = string
  description = "Git username"
}

variable "git_host" {
  type        = string
  default     = "github.com"
}

variable "git_type" {
  default = "github"
}

variable "git_org" {
  default = "cloud-native-toolkit-test"
}

variable "git_repo" {
  default = "gitops-test"
}

variable "gitops_namespace" {
  default = "openshift-gitops"
}

variable "server_url" {
}

variable "cluster_username" {
}

variable "cluster_password" {
}

variable "ingress_subdomain" {
  default = ""
}

variable "gitea_username" {
  type = string
  description = "The username for the instance"
  default = "gitea-admin"
}
variable "gitea_password" {
  type = string
  description = "The password for the instance"
  default = ""
}
variable "gitea_instance_name" {
  type = string
  description = "The name for the instance"
  default = "gitea"
}
variable "gitea_namespace_name" {
  type = string
  description = "The value that should be used for the namespace"
  default = "gitea"
}
