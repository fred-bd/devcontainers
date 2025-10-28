folder('devops')

pipelineJob("devops/configure-vault") {
  parameters {
    stringParam('VaultAddr', 'http://localhost:8200', 'The address to the vault')
    stringParam('CommonName', 'bede-apps.com', 'The common name allowed for certificates issuers.')
  }

  displayName("Configure vault resources")
  keepDependencies(false)
  throttleConcurrentBuilds {
    maxPerNode(0)
    maxTotal(0)
    throttleDisabled(true)
  }
  definition {
    cps {
      script('''@Library("jenkins-shared@main")_
configureVault { 
  credentialId="vaultAdminToken"
  agentName="vault-agent"
}''')
      sandbox(true)
    }
  }
}

pipelineJob("devops/configure-flux") {
  parameters {
    stringParam('VaultAddr', 'http://localhost:8200', 'The address to the vault')
    stringParam('KubeFilePath', 'cluster-hosts/note', 'The path to vault secret containing kubeconfig file')
    stringParam('KubeFileSecret', 'note-kubeconfig', 'The key name of the secret containing kubeconfig file')
    booleanParam('CleanFluxResources', false, 'Remove all resources from the cluster including flux')
    booleanParam('ConfigureSharding', false, 'Use additional shard controllers')
    stringParam('KubeAuthNs', 'cert-manager,grafana,kiali', 'Namespaces to copy kubernetes auth secret to use in vault')
    stringParam('FluxConfigRepo', 'https://github.com/fred-bd/flux-clusters-configurations.git', 'The repository containing the flux configurations')
    stringParam('FluxConfigRepoPath', 'overlays/prod', 'Location within the repository of the main configuration')
  }

  displayName("Configure flux resources")
  keepDependencies(false)
  throttleConcurrentBuilds {
    maxPerNode(0)
    maxTotal(0)
    throttleDisabled(true)
  }
  definition {
    cps {
      script('''@Library("jenkins-shared@main")_
configureFlux { 
  credentialId="vaultAdminToken"
  agentName="kube-agent"
  helmSecretPath="helm-repo-credentials/chartmuseum"
  helmUserKey="user_name"
  helmPasswordKey="user_password"
}''')
      sandbox(true)
    }
  }
}
