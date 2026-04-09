# Java Maven CI/CD Pipeline with Jenkins, Docker & GitHub

##  Project Overview

This project demonstrates a complete **CI/CD pipeline** for a Java Maven application using Jenkins, Docker, and GitHub Webhooks.

The pipeline automatically builds, packages, containerizes, and pushes the application to Docker Hub whenever code is pushed to the repository.

---

##  Architecture

```text
GitHub → Webhook → Jenkins (Docker on DigitalOcean)
        → Maven Build → Docker Build → Docker Hub
```

---

## Tech Stack

* Java (Maven)
* Jenkins (running in Docker)
* Docker
* GitHub (Version Control & Webhooks)
* DigitalOcean (Droplet hosting Jenkins)

---

## CI/CD Pipeline Flow

1. Developer pushes code to GitHub
2. GitHub Webhook triggers Jenkins pipeline
3. Jenkins Multibranch Pipeline detects branch
4. Pipeline stages:

   * Build JAR (Maven)
   * Build Docker Image
   * Push Image to Docker Hub
   * Version bump & commit back to repository
5. Docker image is ready for deployment

---

## Jenkins Setup

* Jenkins runs inside a Docker container on a DigitalOcean droplet
* Docker socket (`/var/run/docker.sock`) is mounted to allow Jenkins to build images
* Jenkins Shared Library is used for reusable pipeline logic

---

## Shared Library Functions

Reusable pipeline steps implemented:

* `buildJar()` → builds Maven artifact
* `buildImage()` → builds Docker image
* `dockerLogin()` → authenticates with Docker Hub using Jenkins credentials
* `dockerPush()` → pushes image to Docker Hub
* `incrementVersion()` → automatically increments the application version
* `gitCommitAndPush()` → commits version updates back to repository

---

## Branch Strategy

* `master` → stable pipeline
* `feature/*` → development and testing
* Multibranch pipeline automatically handles all branches

---

## Webhook Integration

* GitHub webhook configured to trigger Jenkins on every push
* Endpoint used:

  ```
  http://<jenkins-server>:8080/github-webhook/
  ```

---

## Docker

* Application is containerized using a lightweight base image
* Docker image is pushed to Docker Hub after every successful build

---

## Credentials Management

* Jenkins credentials store is used for:

  * GitHub authentication
  * Docker Hub authentication

---

## Key Challenges & Solutions

### 1. Branch Push Issues

* Problem: Pipeline was pushing to a fixed branch
* Solution: Used `env.BRANCH_NAME` to dynamically push to the correct branch

### 2. Infinite Build Loop

* Problem: Jenkins commit triggered webhook repeatedly
* Solution: Added `[skip ci]` to commit messages

### 3. Docker Access in Jenkins

* Solution: Mounted Docker socket into Jenkins container

---

## Key Features

* Automated CI pipeline with Jenkins
* Multibranch pipeline support
* GitHub webhook integration
* Docker image build & push
* Shared library for reusable pipeline logic
* Dynamic branch handling
* Version bump automation

---

## 📸 (Optional)

Add screenshots here:

* Jenkins pipeline view
* Successful build logs
* Docker Hub repository

---

## 📬 Future Improvements

* Add automated testing stage
* Implement environment-based deployments (dev/staging/prod)
* Add Docker image version tagging strategy
* Integrate security scanning tools

---

## Author

**Onyekaozuru Tochukwu David**

---

## Final Note

This project demonstrates practical DevOps skills including CI/CD automation, containerization, and pipeline design using industry-standard tools.
