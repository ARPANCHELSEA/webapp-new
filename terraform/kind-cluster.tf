provider "kind" {}

resource "kind_cluster" "dev" {
  name           = "dev-cluster"
  wait_for_ready = true

  node_image = "kindest/node:v1.27.0"
  config = <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
EOF
}