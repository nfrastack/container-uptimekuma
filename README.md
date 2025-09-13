# nfrastack/container-uptimekuma

## About

This repository will build a container for [Uptime Kuma](https://uptime.kuma.pet/), A service availability application.

## Maintainer

* [Nfrastack](https://www.nfrastack.com)

## Table of Contents


* [About](#about)
* [Maintainer](#maintainer)
* [Table of Contents](#table-of-contents)
* [Installation](#installation)
  * [Prebuilt Images](#prebuilt-images)
  * [Quick Start](#quick-start)
  * [Persistent Storage](#persistent-storage)
* [Configuration](#configuration)
  * [Environment Variables](#environment-variables)
    * [Base Images used](#base-images-used)
    * [Core Configuration](#core-configuration)
  * [Users and Groups](#users-and-groups)
  * [Networking](#networking)
* [Maintenance](#maintenance)
  * [Shell Access](#shell-access)
* [Support & Maintenance](#support--maintenance)
* [License](#license)

## Installation

### Prebuilt Images

Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-uptimekuma/pkgs/container/container-uptimekuma) and [Docker Hub](https://hub.docker.com/r/nfrastack/uptimekuma).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-uptimekuma:(image_tag)
docker.io/nfrastack/uptimekuma:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>`

Example:

`ghcr.io/nfrastack/container-uptimekuma:latest` or

`ghcr.io/nfrastack/container-uptimekuma:1.0` or

* `latest` will be the most recent commit
* An otpional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest
* If there are multiple distribution variations it may include a version - see the registry for availability

Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map persistent storage for access to configuration and data files for backup.
* Set various environment variables to understand the capabilities of this image.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description     |
| --------- | --------------- |
| `/data`   | SQLite Database |
| `/logs`   | Logfiles        |

## Configuration

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description      |
| ------------------------------------------------------- | ---------------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image       |
| [Nginx](https://github.com/nfrastack/container-nginx/)  | Web Server Image |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Core Configuration

| Variable      | Description                       | Default          |
| ------------- | --------------------------------- | ---------------- |
| `DATA_PATH`   | Path where to store database      | `/app/data/`     |
| `LISTEN_PORT` | Uptime Kuma Listening Port        | `3001`           |
| `LOG_TYPE`    | Log to `CONSOLE` `FILE` or `BOTH` | `FILE`           |
| `LOG_PATH`    | Log Path                          | `/logs/`         |
| `LOG_FILE`    | Log file name                     | `uptimekuma.log` |

## Users and Groups

| Type  | Name  | ID   |
| ----- | ----- | ---- |
| User  | `uptimekuma` | 2323 |
| Group | `uptimekuma` | 2323 |

### Networking

| Port | Protocol | Description |
| ---- | -------- | ----------- |
| `80` | `tcp` | HTTP Listening Port (Nginx Proxy) |
| `3001` | `tcp` | Uptime Kuma Listening Port |

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.


## Support & Maintenance

* For community help, tips, and community discussions, visit the Discussions board.
* For personalized support or a support agreement, see Nfrastack Support.
* To report bugs, submit a Bug Report. Usage questions will be closed as not-a-bug.
* Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
* Updates are best-effort, with priority given to active production use and support agreements.

## References

* <https://uptime.kuma.pet/>

## License

This project is licensed under the MIT License - see the LICENSE file for details.
