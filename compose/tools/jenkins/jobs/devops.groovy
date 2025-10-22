folder('devops')

pipelineJob("devops/configure-vault") {
  // parameters {
  //   stringParam('Name', '', 'Your CNE will be prefixed with prod-cne')
  //   stringParam('BackupFileName', '', 'Full file name of database backup you want loaded, including tar.gz. Example: "Store-1213-20221026080010.tar.gz"')
  // }
  // displayName("prod-cne")
  keepDependencies(false)
  throttleConcurrentBuilds {
    maxPerNode(0)
    maxTotal(0)
    throttleDisabled(true)
  }
  definition {
    cps {
      script('''@Library("infra-shared@main")_
configureVault {}''')
      sandbox(true)
    }
  }
}
