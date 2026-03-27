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
```
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

## Phase 3: Sample application Helm charts

Phase 3 introduces the first reusable Helm chart for workloads managed by the GitOps platform.

What was added:
- a `sample-app` Helm chart under `apps/`
- Helm templates for Namespace, Deployment, and Service
- a reusable values-based structure for future environment promotion
- a clean packaging model for Argo CD application delivery in later phases

This phase establishes the application packaging layer that will be deployed into dev in the next phase.

## Phase 4: Dev environment deployment

Phase 4 deploys the first real workload into the dev environment through Argo CD.

What was added:
- a dev-specific Helm values file for the sample application
- a child Argo CD Application in `platform/dev`
- automated sync for the sample app into the `sample-app` namespace

Deployment flow:
1. `root-app` syncs `clusters/dev`
2. `platform-root` is created from `clusters/dev/apps/platform-root.yaml`
3. `platform-root` reads the `platform/dev` path
4. `sample-app-dev` is created and deploys the Helm chart from `apps/sample-app`

This phase establishes the first end-to-end GitOps application deployment in the dev environment.


## Phase 5: Stage and prod environments

Phase 5 expands the GitOps platform from a single dev environment to a multi-environment structure with separate stage and prod delivery paths.

What was added:

- `clusters/stage` and `clusters/prod` GitOps entrypoints
- `platform/stage` and `platform/prod` Argo CD Applications
- `values-stage.yaml` and `values-prod.yaml` for Helm-based environment configuration
- isolated namespaces for dev, stage, and prod deployments in the same cluster
- root app expansion from `clusters/dev` to the full `clusters/` hierarchy

Environment layout:

- `dev` → `sample-app-dev`
- `stage` → `sample-app-stage`
- `prod` → `sample-app-prod`

Bootstrap flow after phase 5:

1. `bootstrap/root-app.yaml` is applied once
2. Argo CD scans `clusters/`
3. Argo CD creates child Applications for dev, stage, and prod
4. each environment points to its own platform path
5. each platform Application deploys the same Helm chart with different values files

This phase establishes the multi-environment GitOps structure that will later be simplified with ApplicationSets in phase 6.

## Phase 6: ApplicationSet implementation

Phase 6 replaces repeated per-environment Argo CD Application manifests with ApplicationSet-based generation.

### What changed

- added `kustomization.yaml` files to `platform/dev`, `platform/stage`, and `platform/prod`
- replaced manual environment Application manifests with environment-specific `ApplicationSet` resources
- kept the existing root app structure unchanged
- continued using environment-specific Helm values files for dev, stage, and prod

### Why this matters

Before this phase, each environment had its own manually written Argo CD `Application` file.

Now each environment uses an `ApplicationSet`, which is a more scalable pattern and better matches production-style GitOps design.

This makes it easier to:
- expand to more applications later
- standardize environment deployment patterns
- reduce repeated Argo CD application definitions

### Current flow

1. cluster root app points to `platform/<env>`
2. `platform/<env>/kustomization.yaml` includes `sample-appset.yaml`
3. the `ApplicationSet` generates the Argo CD Application for that environment
4. Helm uses the correct values file:
   - dev → `values-dev.yaml`
   - stage → `values-stage.yaml`
   - prod → `values-prod.yaml`


## Phase 7: Platform services layer

Phase 7 introduces the first shared cluster service layer managed through Argo CD.

What was added:

* a new cluster-level `platform-services-root` Application under `clusters/core/apps`
* a shared `platform/services` GitOps path for cluster-wide services
* the first platform service: `cert-manager`
* separation between environment workloads and shared cluster services

Why this matters:

* application workloads still live under `platform/dev`, `platform/stage`, and `platform/prod`
* shared services should be installed once per cluster, not once per environment
* this creates a cleaner production-style GitOps structure for later phases like sync waves, RBAC, secrets, and monitoring