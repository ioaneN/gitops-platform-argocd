# GitOps Argo CD Platform

A senior-level GitOps portfolio project built with Kubernetes, Argo CD, Helm, and multi-environment GitOps deployment patterns.

## Project overview

This repository is designed to demonstrate how to build a production-style GitOps platform where Git is the source of truth and Argo CD continuously reconciles the Kubernetes cluster to the desired state.

The project will evolve phase by phase and will include:

- Argo CD as the GitOps controller
- App of Apps bootstrap pattern
- Helm-based application packaging
- separate dev, stage, and prod environments
- ApplicationSets for scalable deployment management
- platform services managed through GitOps
- sync waves and dependency ordering
- Argo CD Projects and RBAC boundaries
- secrets and configuration management
- monitoring and operational visibility

## Planned phases

1. Foundation / repo structure / local cluster / Argo CD install
2. Root App / App of Apps bootstrap
3. Sample application Helm charts
4. Dev environment deployment
5. Stage and prod environments
6. ApplicationSet implementation
7. Platform services layer
8. Sync waves / ordering / dependency flow
9. Projects and RBAC
10. Secrets and configuration management
11. Monitoring and operational visibility
12. Docs / polish / production readiness

## Repository structure

```text
gitops-argocd-platform/
├── README.md
├── docs/
│   └── architecture.md
├── bootstrap/
│   └── argocd/
│       └── install.md
├── clusters/
│   ├── dev/
│   ├── stage/
│   └── prod/
├── apps/
├── platform/
└── scripts/