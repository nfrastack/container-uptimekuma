# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL \
        org.opencontainers.image.title="Uptime Kuma" \
        org.opencontainers.image.description="Service availability and monitoring platform" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/uptimekuma" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-uptimekuma/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-uptimekuma.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ARG \
    UPTIMEKUMA_VERSION="2.1.3" \
    UPTIMEKUMA_REPO_URL="https://github.com/louislam/uptime-kuma"

ENV \
    IMAGE_NAME="nfrastack/uptimekuma" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-uptimekuma/"

RUN echo "" && \
    BUILD_ENV=" \
                10-nginx/ENABLE_NGINX=FALSE \
                10-nginx/NGINX_MODE=proxy \
                10-nginx/NGINX_PROXY_URL='http://localhost:[env:LISTEN_PORT}' \
                10-nginx/NGINX_SITE_ENABLED=uptimekuma \
              " \
              && \
    UPTIMEKUMA_BUILD_DEPS_ALPINE=" \
                                        git \
                                        npm \
                                    " \
                                && \
    \
    UPTIMEKUMA_RUN_DEPS_ALPINE=" \
                                    chromium \
                                    jq \
                                    mariadb-client \
                                    nodejs \
                                    sqlite \
                                " \
                                && \
    source /container/base/functions/container/build && \
    container_build_log image && \
    create_user uptimekuma 8080 uptimekuma 8080 /dev/null && \
    package update && \
    package upgrade && \
    package install \
                        UPTIMEKUMA_BUILD_DEPS \
                        UPTIMEKUMA_RUN_DEPS \
                    && \
    \
    clone_git_repo "${UPTIMEKUMA_REPO_URL}" "${UPTIMEKUMA_VERSION}" && \
    build_assets src ${GIT_REPO_SRC_UPTIMEKUMA} && \
    build_assets scripts && \
    mkdir -p /app && \
    cp .npmrc /app && \
    cp package*.json /app && \
    npm ci && \
    npm run build && \
    cp -R dist db server src /app/ && \
    cd /app/ && \
    npm ci --omit=dev && \
    chown -R uptimekuma:uptimekuma /app && \
    container_build_log add "Uptime Kuma" "${UPTIMEKUMA_VERSION}" "${UPTIMEKUMA_REPO_URL}" && \
    \
    package remove \
                    UPTIMEKUMA_BUILD_DEPS \
                    && \
    \
    package cleanup && \
    rm -rf \
            /build-assets

COPY rootfs /
