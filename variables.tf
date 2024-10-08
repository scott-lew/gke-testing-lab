variable "billing_account" {
  type        = string
  description = "(required) Billing account to attach to the project."
}

variable "cloud_sql_settings" {
  type        = map(string)
  description = "(optional) Map of CloudSQL settings."
  default = {
    "database_version" = "POSTGRES_13"
    "tier"             = "db-g1-small"
  }
}

variable "enabled_services" {
  type        = list(string)
  description = "(optional) List of service APIs to enable."
  default = [
    "container.googleapis.com",
    "stackdriver.googleapis.com",
    "servicenetworking.googleapis.com",
    "gkehub.googleapis.com",
    "gkeconnect.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "mesh.googleapis.com",
  ]
}

variable "gke_enable_hub" {
  type        = bool
  description = "(optional) Register GKE cluster(s) to GKE Hub."
  default     = true
}

variable "gke_node_pool_settings" {
  type        = map(any)
  description = "(optional) Map of node pool settings."
  default = {
    "count"        = 3           # Number of nodes
    "disk_size_gb" = 50          # Size of disk to attach to each node
    "machine_type" = "e2-medium" # Instance type to use for each node
  }
}

variable "labels" {
  type        = map(string)
  description = "(optional) Map of labels to assign to infrastructure deployed."
  default = {
    "environment" = "tenant"
  }
}

variable "parent" {
  type        = string
  description = "(required) Parent folder or oranization to place the project in."
}

variable "provision_addons" {
  type        = map(bool)
  description = "(optional) Map of add-on services to provision."
  default = {
    "bastion"  = true
    "cloudsql" = true
  }
}

variable "region" {
  type        = string
  description = "(optional) Default GCP region to deploy to."
  default     = "us-central1"
}

variable "vpc_network_name" {
  type        = string
  description = "(optional) Name of the VPC network to use."
  default     = "default"
}

variable "vpc_subnet_name" {
  type        = string
  description = "(optional) Name of the VPC subnetwork to use."
  default     = "default"
}

variable "zone" {
  type        = string
  description = "(optional) Default GCP zone to deploy to."
  default     = "us-central1-a"
}
