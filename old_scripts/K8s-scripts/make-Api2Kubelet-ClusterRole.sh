#!/bin/bash
# configure RBAC permissions to allow the Kubernetes API Server to access the Kubelet API
# on each worker node. Access to the Kubelet API is required for retrieving metrics, logs,
# and executing commands in pods.
#
# The commands in this section will effect the entire cluster
# and only need to be run once from one of the controller nodes.!!!

cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
rules:
  - apiGroups:
      - ""
    resources:
      - nodes/proxy
      - nodes/stats
      - nodes/log
      - nodes/spec
      - nodes/metrics
    verbs:
      - "*"
EOF
