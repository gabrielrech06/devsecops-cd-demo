# DevSecOps Continuous Deployment Demo

A small academic project demonstrating a Continuous Deployment pipeline integrated with DevSecOps practices.

The project was developed for a university seminar and deployed on a self-hosted Debian server.

## Pipeline

Pull requests must pass two checks before being merged into `main`:

- Application validation
- Secret scanning with Gitleaks

After a successful merge, GitHub Actions automatically deploys the new version using a self-hosted runner.

Each deployment is stored as an immutable release identified by its Git commit SHA. The active release is switched atomically using a symbolic link, which also allows simple rollbacks.

## Stack

- GitHub Actions
- Gitleaks
- Docker
- Nginx
- Bash

## Security

The demo includes protected branches, required security checks, secret scanning, a least-privilege deployment user, and restricted network access.

> The self-hosted runner used during the live demonstration was disconnected.
