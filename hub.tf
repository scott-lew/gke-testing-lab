module "tenant-cluster-hub" {
  count  = var.gke_enable_hub ? 1 : 0
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-hub?ref=v21.0.0"

  depends_on = [
    module.tenant-cluster-nodepool-1
  ]

  project_id = module.project.project_id

  clusters = {
    tenant-cluster = module.tenant-cluster.id
  }

  features = {
    configmanagement = true
    servicemesh      = false
  }

  configmanagement_templates = {
    default = {
      binauthz = false
      config_sync = {
        git = {
          gcp_service_account_email = null
          https_proxy               = null
          policy_dir                = "configsync/clusters/tenant-cluster-1"
          secret_type               = "none"
          source_format             = "hierarchy"
          sync_branch               = "main"
          sync_repo                 = "https://github.com/jacobmammoliti/gke-testing-lab"
          sync_rev                  = null
          sync_wait_secs            = null
        }
        prevent_drift = false
        source_format = "hierarchy"
      }
      hierarchy_controller = {
        enable_hierarchical_resource_quota = true
        enable_pod_tree_labels             = true
      }
      policy_controller = {
        audit_interval_seconds     = 120
        exemptable_namespaces      = []
        log_denies_enabled         = true
        referential_rules_enabled  = true
        template_library_installed = true
      }
      version = "1.14.3"
    }
  }
  configmanagement_clusters = {
    "default" = ["tenant-cluster"]
  }
}