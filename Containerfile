FROM registry.access.redhat.com/ubi8/ubi:8.2

# Home directories required by acme.sh script.
ENV OCP_TOOLS_VERSION=4.12
ENV ACME_VERSION=3.0.5

# OpenSSL, curl and socat required for script.
RUN dnf makecache && \
    dnf install -y \
    openssl socat curl \
    && dnf clean all && rm -rf /var/cache/dnf/*

WORKDIR /download

RUN curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$OCP_TOOLS_VERSION/openshift-client-linux.tar.gz | tar -xz && \
    mv oc /usr/bin/oc && \
    mv kubectl /usr/bin/kubectl

WORKDIR /source

RUN curl -L https://github.com/acmesh-official/acme.sh/archive/$ACME_VERSION.tar.gz | tar -xz

WORKDIR /scripts

COPY scripts .

WORKDIR /
