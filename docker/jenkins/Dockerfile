FROM jenkins/jenkins:2.528.1-lts-jdk21
LABEL maintainer="Frederico Bedê <bede.apps@gmail.com>"

USER root

# Skip initial setup
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# Copy plugins to install
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins
RUN jenkins-plugin-cli \
  -f /usr/share/jenkins/ref/plugins.txt \
  --latest \
  --clean-download-directory

RUN mkdir -p /var/configurations/casc && \
  mkdir -p /var/configurations/certs && \
  mkdir -p /var/configurations/jobs && \
  chown -R jenkins:jenkins /var/configurations

VOLUME ["/var/configurations/casc", "/var/configurations/casc", "/var/configurations/certs"]

USER jenkins