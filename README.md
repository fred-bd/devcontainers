# Project Documentation

This project contains various Docker Compose configurations and container setups for development and deployment.

## Table of Contents
- [Overview](#overview)
- [Documentation](#documentation)
- [Environment Variables](#environment-variables)
- [Secrets](#secrets)
- [Usage](#usage)

## Overview

This repository includes Docker Compose files for setting up different services and development environments. The configurations are organized into several directories:

- `compose/`: Contains Docker Compose configurations.
- `containers-configs/`: Contains container configurations and scripts.
- `docker/`: Contains Dockerfiles for building images.
- `docs/`: Contains documentation for different setups.

## Documentation

For detailed setup and usage instructions, refer to the following documents:

- [CIT Coder Devcontainer](docs/cit-coder-devcontainer.md)
- [DevOps Devcontainer](docs/devops-devcontainer.md)
- [FullStack Devcontainer](docs/fullstack-devcontainer.md)

## Environment Variables

The environment variables are defined in the `env` directory. Here are the variables used:

- `vars.env`
  - `USER`
  - `FLOW_API_KEY`
  - `FLOW_API_SECRET`

- `pg-vars.env`
  - `POSTGRES_USER`
  - `POSTGRES_DB`

## Secrets

The secrets are stored in the `secrets` directory. Here are the secret files and their corresponding variables:

- `flow-api-key.txt`
  - `FLOW_API_KEY`
- `flow-api-secret.txt`
  - `FLOW_API_SECRET`
- `chartmuseum.txt`
  - `CHARTMUSEUM_CONFIGS`
- `pg-password.txt`
  - `PG_PASSWORD`
- `pgadmin-password.txt`
  - `PGADMIN_PASSWORD`

## Usage

### Installing VSCode

To get started, you need to install Visual Studio Code (VSCode). You can download it from the official website: [Download VSCode](https://code.visualstudio.com/).

### Installing DevContainers Extension

After installing VSCode, you need to install the DevContainers extension. You can find it in the VSCode marketplace or install it directly from this link: [DevContainers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

### Running the Containers

To run the containers, open one of the subdirectories in `containers-configs` (e.g., `cit-coder` or `devops`) in VSCode. Once the directory is open, VSCode will prompt you to reopen the folder in a container. Follow the prompts to set up and start the development container.

Alternatively, you can use the command palette (Ctrl+Shift+P) and select `Remote-Containers: Reopen in Container`.

Make sure to set the necessary environment variables and secrets before running the services.

For more detailed instructions, refer to the documentation links provided above.