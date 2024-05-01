locals {
  tkgs_cluster_variables = {
    "controlPlaneCertificateRotation" : {
      "activate" : true,
      "daysBefore" : 30
    },
    "defaultStorageClass" : "tanzu-storage-policy",
    "defaultVolumeSnapshotClass" : "volumesnapshotclass-delete",
    "nodePoolLabels" : [
    ],
    "nodePoolVolumes" : [
      {
        "capacity" : {
          "storage" : "20G"
        },
        "mountPath" : "/var/lib/containerd",
        "name" : "containerd",
        "storageClass" : "tanzu-storage-policy"
      },
      {
        "capacity" : {
          "storage" : "20G"
        },
        "mountPath" : "/var/lib/kubelet",
        "name" : "kubelet",
        "storageClass" : "tanzu-storage-policy"
      }
    ],
    "ntp" : "172.16.20.10",
    "storageClass" : "tanzu-storage-policy",
    "storageClasses" : [
      "tanzu-storage-policy"
    ],
    "vmClass" : "best-effort-small"
  }

  tkgs_nodepool_a_overrides = {
    "nodePoolLabels" : [
      {
        "key" : "sample-worker-label",
        "value" : "value"
      }
    ],
    "storageClass" : "tanzu-storage-policy",
    "vmClass" : "best-effort-small"
  }
}

resource "tanzu-mission-control_tanzu_kubernetes_cluster" "tkgs_cluster" {
  name                    = "workload01-cls03"
  management_cluster_name = "vxrail"
  provisioner_name        = "workload01"

  spec {
    cluster_group_name = "default"

    topology {
      version           = "v1.26.5+vmware.2-fips.1-tkg.1"
      cluster_class     = "tanzukubernetescluster"
      cluster_variables = jsonencode(local.tkgs_cluster_variables)

      control_plane {
        replicas = 1

        os_image {
          name    = "photon"
          version = "3"
          arch    = "amd64"
        }
      }

      nodepool {
        name        = "md-0"
        description = "simple small md"

        spec {
          worker_class = "node-pool"
          replicas     = 1
          overrides    = jsonencode(local.tkgs_nodepool_a_overrides)

          os_image {
            name    = "photon"
            version = "3"
            arch    = "amd64"
          }
        }
      }

      network {
        pod_cidr_blocks = [
          "100.96.0.0/11",
        ]
        service_cidr_blocks = [
          "100.64.0.0/13",
        ]
        service_domain = "cluster.local"
      }
    }
  }

  timeout_policy {
    timeout             = 60
    wait_for_kubeconfig = true
    fail_on_timeout     = true
  }
}