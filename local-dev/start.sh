#!/bin/bash
git clone https://github.com/hashicorp/consul-helm.git

helm init

helm upgrade --install nginx-ingress stable/nginx-ingress --set controller.hostNetwork=true
helm upgrade --install dashboard stable/kubernetes-dashboard -f ./dashboard.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep default-token | awk '{print $1}')
helm upgrade --install consul ./consul-helm -f ./consul_values.yaml

kubectl apply -f ./consul_ingres.yaml

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
  name: kube-dns
  namespace: kube-system
data:
  stubDomains: |
    {"consul": ["$(kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}')"]}
EOF

kubectl apply -f ./echo.yaml
helm upgrade --install foaas-db stable/mysql --set mysqlDatabase=foaas
kubectl apply -f ../k8s/