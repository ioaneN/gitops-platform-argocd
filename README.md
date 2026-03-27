# GitOps Platform with Argo CD

A production-style GitOps platform project built with Argo CD, Helm, App of Apps, and ApplicationSets.

This repository demonstrates how to structure and manage Kubernetes application delivery across multiple environments using GitOps principles. It is designed as a portfolio project to reflect senior-level DevOps and platform engineering practices, with a focus on environment separation, reusable deployment patterns, and scalable repository structure.

## Project Goals

The goal of this project is to build a clean, extensible GitOps platform that shows how Argo CD can be used to manage:

- multi-environment deployments
- reusable Helm-based applications
- App of Apps bootstrapping
- ApplicationSet-based templated delivery
- platform service layering
- sync-wave-based ordering and dependency control

This repository is intentionally structured to look and feel like a real GitOps platform foundation rather than a basic Argo CD demo.

---

## Architecture Overview

The platform follows a GitOps pull-based model:

1. Kubernetes runs Argo CD inside the cluster
2. Argo CD watches this Git repository
3. Desired state is defined in Git
4. Argo CD continuously reconciles cluster state with Git state
5. Applications are deployed through Helm and organized by environment

### Core patterns used

- **GitOps** as the deployment operating model
- **Argo CD App of Apps** for platform bootstrapping
- **Helm** for reusable application packaging
- **ApplicationSets** for templated multi-environment app generation
- **Sync Waves** for ordering dependent resources
- **Environment separation** for dev, stage, and prod

---

## Repository Structure

```text
.
├── apps/
│   └── sample-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-stage.yaml
│       ├── values-prod.yaml
│       └── templates/
│
├── bootstrap/
│   └── root-app.yaml
│
├── clusters/
│   ├── dev/
│   │   └── apps/
│   ├── stage/
│   │   └── apps/
│   └── prod/
│       └── apps/
│
├── platform/
│   ├── bootstrap/
│   │   ├── stage/
│   │   └── prod/
│   ├── dev/
│   ├── stage/
│   └── prod/
│
└── README.md
```

## Directory Purpose

### `apps/`
Contains deployable Helm charts, such as the sample application.

### `bootstrap/`
Contains the root Argo CD Application used to bootstrap the platform.

### `clusters/`
Contains environment-specific Argo CD Applications that point Argo CD to each environment's platform layer.

### `platform/`
Contains environment-level GitOps definitions, including ApplicationSets and bootstrap flows for stage and prod.

## Implemented Phases

This project was built phase by phase:

- Foundation / repo structure / local cluster / Argo CD install
- Root App / App of Apps bootstrap
- Sample application Helm charts
- Dev environment deployment
- Stage and prod environments
- ApplicationSet implementation
- Platform services layer
- Sync waves / ordering / dependency flow
- Docs / polish / production readiness

> Note: Governance, secrets management, and operational monitoring are intentionally left as future extensions to keep this version focused, publishable, and portfolio-ready.

## Environment Model

The repository is structured around three environments:

- dev
- stage
- prod

Each environment is managed independently through GitOps definitions, while still following the same overall platform structure.

This reflects a common real-world pattern:

- dev for rapid iteration
- stage for pre-production validation
- prod for stable production releases

## Bootstrapping Flow

The platform is bootstrapped through a root Argo CD Application.

### Flow

1. Apply the root app
2. Root app scans the `clusters/` directory
3. Environment applications are created
4. Each environment points to its platform definitions
5. Platform definitions deploy application sets and workloads
6. Argo CD reconciles everything continuously

This creates a scalable and declarative deployment model where Git is the source of truth.

## Helm Usage

The sample application is packaged as a Helm chart and uses separate values files for different environments.

Examples:

- `values-dev.yaml`
- `values-stage.yaml`
- `values-prod.yaml`

This pattern keeps application templates reusable while allowing each environment to control its own settings.

## ApplicationSet Usage

ApplicationSets are used to generate environment-specific applications from a shared template.

This avoids duplication and makes the repository more scalable as more applications or environments are added later.

Benefits of using ApplicationSets here:

- less YAML duplication
- consistent application definitions
- easier multi-environment expansion
- cleaner GitOps structure

## Sync Waves

Sync waves are used to control deployment order.

This is important when some resources should be created before others, such as:

- platform bootstrap components before apps
- namespaces before workloads
- dependencies before dependent applications

This project includes sync-wave-based ordering to reflect real GitOps dependency management patterns.

## Why This Project Is Valuable

This project demonstrates more than just Argo CD installation.

It shows how to think about:

- GitOps repository design
- multi-environment delivery
- scalable Argo CD structure
- reusable Helm packaging
- deployment ordering
- platform-oriented Kubernetes delivery

This makes it a strong portfolio project for DevOps, Platform Engineer, and SRE roles.

## What Could Be Added Next

Future improvements for a more production-complete version:

- Argo CD Projects and RBAC
- External Secrets or sealed secrets integration
- Prometheus / Grafana / Loki observability stack
- policy enforcement with Kyverno or OPA
- image updater automation
- notifications and alerting
- multi-cluster expansion
- CI validation for GitOps manifests

## Local Usage

### Prerequisites

- Kubernetes cluster (Minikube, Kind, or similar)
- `kubectl`
- Helm
- Argo CD installed in the cluster

### Apply the root app

```bash
kubectl apply -f bootstrap/root-app.yaml
```

### Check Argo CD applications

```bash
kubectl get applications -n argocd
```

### Render Helm chart locally

```bash
helm template sample-app apps/sample-app
```

## Skills Demonstrated

- Kubernetes
- Argo CD
- GitOps
- Helm
- ApplicationSets
- App of Apps pattern
- Sync waves
- environment-based deployment design
- repository architecture for platform engineering
