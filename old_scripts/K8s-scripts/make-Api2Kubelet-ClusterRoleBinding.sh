#!/bin/bash
#
# The Kubernetes API Server authenticates to the Kubelet as the kubernetes user
# using the client certificate as defined by the --kubelet-client-certificate flag.

# Bind the system:kube-apiserver-to-kubelet ClusterRole to the kubernetes user:
#


cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: system:kube-apiserver
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:kube-apiserver-to-kubelet
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: kubernetes
EOF
