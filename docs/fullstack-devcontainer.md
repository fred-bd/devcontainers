# Fullstack Devcontainer Documentation

Welcome to the Fullstack Devcontainer setup guide! This documentation is designed to help you get started with the development environment for our full-stack project. This guide is aimed at novice software engineers who may not be familiar with the tools and technologies used in this setup.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Tools and Technologies](#tools-and-technologies)
- [Setup Instructions](#setup-instructions)
- [Running the Containers](#running-the-containers)
- [Installed Tools](#installed-tools)
- [Environment Variables](#environment-variables)
- [Scripts Explanation](#scripts-explanation)
- [Useful Links](#useful-links)

## Overview

This project uses Docker and Docker Compose to create a consistent development environment. The setup includes various services such as PostgreSQL, HashiCorp Vault, and a local Artifactory server. The development environment is configured using a Devcontainer, which allows you to develop inside a Docker container using Visual Studio Code (VSCode).

## Prerequisites

Before you begin, make sure you have the following installed on your machine:
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Visual Studio Code (VSCode)](https://code.visualstudio.com/)
- [Dev Containers Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Tools and Technologies

### Docker
Docker is a platform that enables you to develop, ship, and run applications inside containers. Containers are lightweight, portable, and ensure that your application runs consistently across different environments.

### Docker Compose
Docker Compose is a tool for defining and running multi-container Docker applications. With Docker Compose, you use a YAML file to configure your application's services, networks, and volumes.

### Visual Studio Code (VSCode)
VSCode is a popular code editor developed by Microsoft. It provides a rich development experience with support for debugging, syntax highlighting, intelligent code completion, and more.

### Dev Containers Extension
The Dev Containers extension for VSCode allows you to open any folder inside a Docker container, taking advantage of the container's isolation and reproducibility.

### PostgreSQL
PostgreSQL is a powerful, open-source relational database system. It is known for its robustness, performance, and standards compliance.

### HashiCorp Vault
Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates.

### Artifactory
Artifactory is a repository manager that supports all major package formats. It is used to store and manage build artifacts.

## Setup Instructions

1. **Clone the Repository**
   Clone the project repository to your local machine:
   ```sh
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Open the Project in VSCode**
   Open the project directory in VSCode:
   ```sh
   code .
   ```

3. **Reopen in Container**
   VSCode should prompt you to reopen the folder in a container. If not, you can use the command palette (Ctrl+Shift+P) and select `Remote-Containers: Reopen in Container`.

4. **Set Environment Variables and Secrets**
   Make sure to set the necessary environment variables and secrets as described in the [README.md](../README.md) file.

## Running the Containers

Once the setup is complete, you can run the containers using Docker Compose. The `full-stack-compose.yaml` file includes all the necessary configurations for the development environment.

To start the containers, run the following command:
```sh
docker-compose -f compose/full-stack-compose.yaml up -d
```

This command will start all the services defined in the `full-stack-compose.yaml` file in detached mode.

## Installed Tools

The Docker image used in this project comes with several pre-installed tools to facilitate development. Here is a list of the main tools included:

- **Python 3.11**: A versatile programming language.
- **pip**: Python package installer.
- **Helm**: A package manager for Kubernetes.
- **kubectl**: Command-line tool for interacting with Kubernetes clusters.
- **yq**: A lightweight and portable command-line YAML processor.
- **Terraform**: Infrastructure as Code (IaC) tool for building, changing, and versioning infrastructure.
- **Vault CLI**: Command-line interface for HashiCorp Vault.
- **Azure CLI**: Command-line tools for managing Azure resources.
- **Docker CLI**: Command-line interface for Docker.
- **Ansible**: An open-source automation tool.
- **Pluto**: A tool for detecting deprecated Kubernetes APIs.
- **Nektos/act**: Run GitHub Actions locally.
- **docker-slim**: Optimize and secure your Docker containers.
- **kubectx**: Switch between Kubernetes contexts.
- **kubens**: Switch between Kubernetes namespaces.
- **Flux CLI**: Command-line interface for Flux, a set of continuous and progressive delivery solutions for Kubernetes.
- **DotNet SDK**: Software development kit for .NET applications.
- **Node.js**: JavaScript runtime built on Chrome's V8 JavaScript engine.
- **NVM**: Node Version Manager, a tool for managing multiple Node.js versions.

## Environment Variables

The environment variables are defined in a `.env` file located in the directory specified by the Docker Compose configuration. Here are the variables used:

- `TENANT`
- `GIT_USER`
- `GIT_USER_EMAIL`
- `PROJECTS_HOST_DIR`
- `DOCKER_CERT_PATH`
- `DOCKER_HOST`
- `DOCKER_TLS`
- `DOCKER_TLS_VERIFY`
- `KUBECONFIG`

The content of the `.env` file should be as follows:
```
TENANT=<your-tenant>
GIT_USER=<your-git-user>
GIT_USER_EMAIL=<your-git-user-email>
PROJECTS_HOST_DIR=<your-projects-host-dir>
DOCKER_CERT_PATH=<your-docker-cert-path>
DOCKER_HOST=<your-docker-host>
DOCKER_TLS=<your-docker-tls>
DOCKER_TLS_VERIFY=<your-docker-tls-verify>
KUBECONFIG=<your-kubeconfig-path>
```

## Scripts Explanation

### postCreate.sh

The `postCreate.sh` script is executed after the container is created. It performs the following tasks:

1. **Add Aliases and NVM Configuration to .zshrc**:
   - Adds several useful aliases for tools like `coder`, `kubectl`, and `git`.
   - Configures NVM (Node Version Manager) for managing Node.js versions.

2. **Install Azure CLI Extensions**:
   - Installs Azure CLI extensions for managing Kubernetes clusters and configurations.

3. **Clone Dracula Theme for Zsh**:
   - Clones the Dracula theme for Zsh from GitHub and sets it as the default theme.

4. **Install Helm Plugin**:
   - Installs the `helm-unittest` plugin for Helm.

### postStart.sh

The `postStart.sh` script is executed each time the container starts. It performs the following tasks:

1. **Unseal Vault**:
   - Unseals HashiCorp Vault using keys stored in a JSON file located at `$HOME/projects/tmp/vault.json`.

2. **Check and Set Git Configurations**:
   - Checks if global Git configurations for user name, user email, safe directory, and default branch are set. If not, it sets them using environment variables.

These scripts help automate the setup and configuration of the development environment, ensuring that all necessary tools and settings are in place.

## Useful Links

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Visual Studio Code Documentation](https://code.visualstudio.com/docs)
- [Dev Containers Extension Documentation](https://code.visualstudio.com/docs/remote/containers)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Artifactory Documentation](https://www.jfrog.com/confluence/display/JFROG/Artifactory)

We hope this guide helps you get started with the full-stack development environment. If you have any questions or run into any issues, please refer to the documentation links provided or reach out to your team for assistance.