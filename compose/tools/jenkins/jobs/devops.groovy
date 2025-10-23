folder('devops')

pipelineJob("devops/configure-vault") {
  parameters {
    stringParam('VaultAddr', 'http://localhost:8200', 'The address to the vault')
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
configureVault { credentialId="vaultAdminToken" }''')
      sandbox(true)
    }
  }
}
