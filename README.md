# Angular CI/CD Olympic App

Angular application used to practice and demonstrate **CI/CD, automated testing, containerization and release automation**.

The application displays Olympic-related data through a simple Angular interface, while the main engineering focus of this repository is the build, test and delivery workflow.

## 🛠️ Tech Stack

* Angular
* TypeScript
* Node.js
* Karma
* ChromeHeadless
* Docker
* Nginx
* GitHub Actions
* GitHub Container Registry
* semantic-release
* Python automation scripts

## ⚙️ CI/CD Pipeline

The GitHub Actions workflow automates the main stages of the development lifecycle.

### Test

The pipeline:

* installs project dependencies
* executes automated tests
* runs tests with ChromeHeadless
* generates JUnit XML reports
* publishes test results for CI analysis

A Python script provides a standardized test execution workflow:

```bash
python run-tests.py
```

Generated reports are collected under:

```text
test-results/reports/
```

### Build

The application is packaged using a **multi-stage Docker build**:

```text
Node.js build stage
        ↓
Angular production build
        ↓
Nginx runtime image
```

The final container contains only the files required to serve the Angular application through Nginx.

### Container Registry

Docker images are automatically published to **GitHub Container Registry (GHCR)**.

The pipeline supports image tags associated with branches and commits.

### Release

Releases from the main branch are automated with **semantic-release**.

The release workflow:

* analyzes commit history
* determines the next semantic version
* creates a GitHub Release
* updates the changelog
* publishes a versioned Docker image to GHCR

## 🧪 Testing

Unit tests are executed with:

* Karma
* ChromeHeadless

Run tests locally:

```bash
npm test
```

JUnit-compatible reports are generated for CI integration.

## 🐳 Docker

The application uses a multi-stage Docker image.

The Angular application is built during the first stage and served by **Nginx** in the runtime stage.

Run the application with Docker Compose:

```bash
docker compose up -d
```

Then open:

```text
http://localhost
```

Stop the application:

```bash
docker compose down
```

## 🚀 Run Locally

### Requirements

* Node.js 20+
* npm

Install dependencies:

```bash
npm ci
```

Start the development server:

```bash
npm start
```

Application:

```text
http://localhost:4200
```

Create a production build:

```bash
npm run build
```

## 📦 Releases

The repository uses automated semantic versioning and GitHub Releases.

Published container images are available through GitHub Container Registry.

## 📌 Project Focus

This repository focuses on applying DevOps practices to an Angular application:

* automated testing
* reproducible builds
* Docker containerization
* CI/CD with GitHub Actions
* automated releases
* container image publishing
* CI-compatible test reporting
