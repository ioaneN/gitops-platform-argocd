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


## Phase 2: Root App / App of Apps bootstrap

Phase 2 introduces the first GitOps bootstrap layer using Argo CD's App of Apps pattern.

What was added:
- a manually applied root Argo CD Application
- a `clusters/dev` GitOps entrypoint
- the first child Application for dev bootstrap structure
- a clean foundation for future environment expansion

Bootstrap flow:
1. Argo CD is installed manually
2. `bootstrap/root-app.yaml` is applied once
3. Argo CD syncs `clusters/dev`
4. child Applications are created from Git

This establishes the core GitOps control pattern for the project.