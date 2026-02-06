# Olympic Games Starter (Angular Front-End)

Welcome to **Olympic Games Starter**. This front-end application (Angular) displays Olympic-related data and provides a simple UI for navigation and visualization.

## Table of Contents

1. Context  
2. Technical Overview  
3. Run Locally (without Docker)  
4. Run with Docker (Compose)  
5. Configuration  
6. Testing  
7. CI/CD (GitHub Actions)  
8. Docker Images & Publishing to GHCR  

## 1) Context

This project is a training application used to practice DevOps fundamentals. The goal is to standardize the build, test, and delivery process (Docker + CI/CD) for an Angular application.

## 2) Technical Overview

- **Front-end framework:** Angular (Node-based build).  
- **Web server (runtime):** Nginx (the Docker image serves the production build).  
- **Build:** multi-stage Docker build (Node build stage → Nginx runtime stage).  
- **Port (Docker):** exposed on **80** (served by Nginx).  
- **Test runner:** Karma + ChromeHeadless (JUnit reports enabled).

## 3) Run Locally (without Docker)

### Prerequisites

- Node.js (20+ recommended by the project requirements)
- npm

### Install dependencies

```bash
npm ci
```
Run the app (development)
```bash
npm start
```
Then open: http://localhost:4200

Build for production
```bash
npm run build
```
The build output is generated in the Angular dist/ directory (exact path depends on the Angular workspace configuration).

4) Run with Docker (docker compose)
Start the application
```bash
docker compose up -d
```
Application: http://localhost

Stop
```bash
docker compose down
```
5) Configuration
This project does not require mandatory environment variables to start in the default configuration.

If you add environment-specific settings later, keep them outside the repository (for example via CI/CD secrets or runtime configuration).

6) Testing
Unit tests (local)
```bash
npm test
```
JUnit report generation
JUnit XML reports are generated in the reports/ directory (Karma junitReporter.outputDir).

Unified test script
The repository includes a run-tests.py script that:

detects the project type

runs unit tests

copies JUnit XML reports into ./test-results/

Run:
```bash
python run-tests.py
```
Example of copied results (Angular side):

test-results/reports/**/*.xml

7) CI/CD (GitHub Actions)
The CI workflow is generic: it works for this Angular repo (and can be identical on the Java/Gradle repo following the same approach).

test job
installs the required tooling (Node or Java depending on the repo)

runs python run-tests.py

publishes JUnit reports (XML files under test-results/**/*.xml)

build job
builds the Docker image from the Dockerfile

pushes to GitHub Container Registry (GHCR) with a readable tag:

branch-SHA (e.g. main-<sha>)

release job
runs on main

executes semantic-release

creates a GitHub Release (tag vX.Y.Z)

also pushes a Docker image tagged with the semantic version: X.Y.Z

8) Docker Images & Publishing to GHCR
Image name
The workflow pushes the image to:

ghcr.io/<owner>/<repo> (computed automatically in the workflow)

Published tags
branch-SHA (e.g. ci-test-<sha>, main-<sha>)

X.Y.Z (after release)

GitHub prerequisites (important)
For GHCR push + release to work, the repository must allow the GitHub Actions token:

Settings → Actions → General → Workflow permissions → Read and write permissions

Quality notes
The Docker image is multi-stage (build then runtime), which keeps the final image small and focused (Nginx only).

Unit tests run in ChromeHeadless and generate JUnit XML reports for CI integration.

::contentReference[oaicite:0]{index=0}

Test