# Argo CD Local Installation

## Create namespace

```bash
kubectl create namespace argocd
```

## Install Argo CD

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Verify installation

```bash
kubectl get pods -n argocd
```
