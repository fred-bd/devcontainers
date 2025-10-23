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
