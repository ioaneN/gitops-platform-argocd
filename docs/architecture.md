
---

## `docs/architecture.md`

```md
# Architecture Overview

## Purpose

This project demonstrates a production-style GitOps platform built around Kubernetes, Argo CD, and Helm.

The main idea is to manage environments and platform components through Git, with Argo CD continuously reconciling the actual cluster state to the desired state stored in the repository.

## Planned architecture

The full project will include:

- Argo CD as the GitOps controller
- App of Apps bootstrap pattern
- Helm-based application deployment
- separate dev, stage, and prod environments
- ApplicationSets for scalable deployment patterns
- platform services managed through GitOps
- sync waves and dependency ordering
- Argo CD Projects and RBAC controls
- secrets and configuration management
- monitoring and operational visibility

## Repository layers

### `clusters/`
Environment-specific GitOps definitions will live here.

Planned environments:

- dev
- stage
- prod

### `apps/`
Application-related manifests, charts, or values will live here.

### `platform/`
Shared platform services will live here, such as ingress, secrets tooling, and monitoring stack components.

### `bootstrap/`
Bootstrap-related manifests and installation guidance will live here, especially for bringing Argo CD under GitOps management.

## Phase 1

Phase 1 establishes the local Kubernetes foundation, installs Argo CD, and prepares the repository structure for future GitOps bootstrapping.

At this stage, the repository is intentionally simple and focused on clean structure rather than full deployment logic.