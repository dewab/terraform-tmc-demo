resource "tanzu-mission-control_cluster_group" "create_cluster_group" {
  name = "test-cluster-group"
  meta {
    description = "test-cluster-group-description"
    labels = {
      "env" : "test",
      "using" : "terraform"
    }
  }
}
