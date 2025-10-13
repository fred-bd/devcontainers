FROM mcr.microsoft.com/devcontainers/base:jammy
LABEL maintainer "Frederico Bedê <fredericot@ciandt.com>"

RUN apt-get update && apt-get install -y\
  gnupg\
  ca-certificates\
  unzip\
  jq\
  openssh-client\
  sshpass\
  apache2-utils\
  iputils-ping\
  net-tools\
  vim\
  dnsutils\
  curl\
  wget\
  git

# Apps versions
ENV HELM_VERSION="v3.10.0"
ENV HELM_DOCS_VERSION="1.14.2"
ENV KUBECTL_VERSION="v1.31.4"
ENV YQ_VERSION="v4.40.5"
ENV TMP_APPS_DIR=/tmp/apps/install

ARG PRODUCT=terraform
ARG VERSION=1.9.1
ARG VAULT_VERSION=1.14.10

RUN mkdir -p ${TMP_APPS_DIR}

# Install ansible
RUN apt update && \
  apt install -y software-properties-common && \
  add-apt-repository -y --update ppa:ansible/ansible && \
  apt install -y ansible 

# Install nektos/act
RUN curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nektos/act/master/install.sh |\
  bash

# Install docker
# Add Docker's official GPG key:
RUN install -m 0755 -d /etc/apt/keyrings &&\
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc &&\
  chmod a+r /etc/apt/keyrings/docker.asc &&\
  # Add the repository to Apt sources:
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
  apt-get update &&\
  apt-get install -y docker-ce-cli

# Install docker-slim
RUN curl\
  -L\
  -o ${TMP_APPS_DIR}/ds.tar.gz\
  https://github.com/slimtoolkit/slim/releases/download/1.40.11/dist_linux.tar.gz &&\
  tar -zxvf ${TMP_APPS_DIR}/ds.tar.gz -C ${TMP_APPS_DIR} &&\
  mv ${TMP_APPS_DIR}/dist_linux/slim ${TMP_APPS_DIR}/dist_linux/mint-sensor ${TMP_APPS_DIR}/dist_linux/docker-slim /tmp/apps/

# Install helm
RUN curl -fsSL\ 
  https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o ${TMP_APPS_DIR}/helm.tar.gz &&\
  tar -zxvf ${TMP_APPS_DIR}/helm.tar.gz -C ${TMP_APPS_DIR} &&\
  mv ${TMP_APPS_DIR}/linux-amd64/helm /tmp/apps/

# Install helm-docs
RUN curl -fsSL\
  https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/helm-docs_${HELM_DOCS_VERSION}_Linux_x86_64.tar.gz\
  -o ${TMP_APPS_DIR}/helm-docs.tar.gz &&\
  tar -zxvf ${TMP_APPS_DIR}/helm-docs.tar.gz -C ${TMP_APPS_DIR} &&\
  mv ${TMP_APPS_DIR}/helm-docs /tmp/apps/

# Download and install kubectl
RUN curl -fsSL\ 
  https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o ${TMP_APPS_DIR}/kubectl &&\
  chmod +x ${TMP_APPS_DIR}/kubectl &&\
  mv ${TMP_APPS_DIR}/kubectl /tmp/apps/

# Download and install terraform
RUN cd ${TMP_APPS_DIR} && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
  wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
  gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS && \
  grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
  unzip ${TMP_APPS_DIR}/${PRODUCT}_${VERSION}_linux_amd64.zip -d /tmp/apps

# Download and install terraform docs
RUN curl -sSLo ${TMP_APPS_DIR}/terraform-docs.tar.gz https://terraform-docs.io/dl/v0.19.0/terraform-docs-v0.19.0-$(uname)-amd64.tar.gz && \
  tar -xzf ${TMP_APPS_DIR}/terraform-docs.tar.gz -C ${TMP_APPS_DIR} && \
  chmod +x ${TMP_APPS_DIR}/terraform-docs && \
  mv ${TMP_APPS_DIR}/terraform-docs /tmp/apps/

# TFLint
RUN curl -fsSL \ 
  https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | \
  bash

# Download and install vault cli
RUN curl -fsSL\
  https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o ${TMP_APPS_DIR}/vault.zip &&\
  unzip ${TMP_APPS_DIR}/vault.zip -d ${TMP_APPS_DIR}/ &&\
  mv ${TMP_APPS_DIR}/vault /tmp/apps/

# Az cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash 

# Download and install yq
RUN wget -qO /tmp/apps/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
  && chmod +x /tmp/apps/yq

# Install kubens (and kubectx)
RUN git clone https://github.com/ahmetb/kubectx ${TMP_APPS_DIR}/kubectx &&\
  chmod +x ${TMP_APPS_DIR}/kubectx/* &&\
  mv ${TMP_APPS_DIR}/kubectx/kubectx ${TMP_APPS_DIR}/kubectx/kubens /tmp/apps/

# Install flux cli
RUN curl -fsSL \
  https://fluxcd.io/install.sh | bash

# Install cilium cli
ARG CILIUM_CLI_VERSION=v0.18.3
ARG CLI_ARCH=amd64

RUN curl -fsSL \
  https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz \
  -o ${TMP_APPS_DIR}/cilium.tar.gz &&\
  tar xzf ${TMP_APPS_DIR}/cilium.tar.gz -C ${TMP_APPS_DIR} &&\
  mv ${TMP_APPS_DIR}/cilium /tmp/apps/

# DotNet
RUN add-apt-repository ppa:dotnet/backports && \
  apt-get update && \
  apt-get install -y \
  dotnet-sdk-9.0 \
  aspnetcore-runtime-9.0

# Remove temporary files
RUN cp -r /tmp/apps/* /usr/local/bin/ &&\
  rm -rf /tmp/apps

ARG USERNAME=guest
ARG OLDUSER_NAME=ubuntu
ARG USER_GID=1000
ARG USER_UID=1000

# Add a non-root user
RUN deluser --remove-home ${OLDUSER_NAME} && \
  groupadd -g ${USER_GID} ${USERNAME} && \
  useradd -m -d /home/${USERNAME} -g ${USER_GID} ${USERNAME} 

# Switch to the non-root user
USER ${USERNAME}

WORKDIR /home/${USERNAME}

RUN mkdir -p /home/${USERNAME}/projects &&\
  mkdir -p /home/${USERNAME}/.kube &&\
  chmod g+rwx -R /home/${USERNAME}
  
VOLUME [ "/home/${USERNAME}/projects", "/home/${USERNAME}/.kube" ]

# Node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | \
  bash

# IstioCLI
RUN curl -sL https://istio.io/downloadIstioctl | sh -