# Docker Analysis Base Image

## Summary

This repo contains Dockerfiles to create a core image for data analysis in R and Python. It also includes configuration files for easy VSCode integration.

## Building the Docker image

### Basic use

The base image can be run using the `docker build` command. For instance, to build the image and name it "analysis_base", run:

`$ docker build -t analysis_base Docker/` 

### Specifying user information

As a workaround to Docker volume permission issues in UNIX, user information within the container can be synced with the host machine user. For intance, the following command creates the "analysis_base" image, with the user's username and group ID in place of the default values:

```bash
$ docker build -t analysis_base \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    Docker/
```

## VS Code Integration

The `.devcontainer` folder contains configuration files for easy integration with VS Code. This code: 

1. Installs additional packages for R and Python integration with VSCode
2. Attaches to the current user's `$HOME/projects` directory (if this directory does not exist, it must either be created, or another workspace must be specified in `.devcontainer/devcontainer.json`)
3. Installs several VSCode extensions and specifies certain settiongs
4. Makes other minor configuration changes (see `.devcontainer/scripts/install_dev_tools.sh`).

### Use

1. Install the VSCode "Docker" and "Remote-Containers" extensions.
2. Clone this repository to `$HOME/projects/docker_base` (It's easiest to use this path for now, though another path could be specified in `devcontainer.json`.)
3. Open the folder in VSCode.
4. In VSCode, run "Remote-Containers: Reopen in container." This will build the image (with a randomly generated name), then launch/configure a container. Once configuration is complete, the workspace will open from within the container.
