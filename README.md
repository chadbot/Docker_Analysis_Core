# Docker Analysis Base Image

## Summary

This repo contains Dockerfiles to create a core image for data analysis in R and Python. It also includes configuration files for easy integration with VS Code (though this is entirely optional).

## Building the Docker image

### Basic use

The base image can be run using the `docker build` command. For example, to build the image and name it "analysis_base", run:

`$ docker build -t analysis_base Docker/` 

### Specifying user information

When using a UNIX host, attaching additional volumes to a Docker image may result in permission errors.As a workaround, user information within the container can be synced with the current user on the host machine. For intance, the following command creates the "analysis_base" image, with the current (host) user's username and group ID in place of the default values:

```bash
$ docker build -t analysis_base \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    Docker/
```

## VS Code Integration

The `.devcontainer` folder contains configuration files for easy integration with R and Python projects in VS Code. This code: 

1. Installs additional packages for R and Python integration with VSCode
2. Attaches to the current user's `$HOME/projects` directory (if this directory does not exist, it must either be created, or another workspace must be specified in `.devcontainer/devcontainer.json`)
3. Installs several VSCode extensions and specifies certain settiongs
4. Makes other minor configuration changes (see `.devcontainer/scripts/install_dev_tools.sh`).

### Use

1. Install the VSCode "Docker" and "Remote-Containers" extensions.
2. Create a `$HOME/projects` directory. All projects should reside within this directory.
3. Clone this repository to `$HOME/projects/docker_base`.
4. Open the folder in the VS Code workspace.
5. In VSCode, run "Remote-Containers: Reopen in container." This will build the image (with a semirandomly generated name), then launch and configure a container. Once configuration is complete, the workspace will open from within the container.
6. The container can now be attached to directly from the host machine by running the "Attach to running container..." command.
7. When inside the container, it can be used as a regular machine, with its own VS Code settings and configurations. 
