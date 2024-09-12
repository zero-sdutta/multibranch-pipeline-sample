parallel([0, 1].collectEntries {b -> ["perfBranch-$b", {
          podTemplate(cloud: 'kubernetes',yaml: '''
apiVersion: v1
kind: Pod
spec:
  nodeSelector:
   kubernetes.io/arch: amd64
  containers:
  - name: jnlp
    resources:
      requests:
        cpu: '256m'
        memory: '640Mi'
      limits:
        memory: '640Mi'
''') {
retry(count: 2, conditions: [kubernetesAgent(), nonresumable()]) {
              node(POD_LABEL) {
                stage("run-$b") {
                  sh "java -cp mock-load-builder.jar mock.MockLoad <480>"
                }
		stage("publish-$b"){
		  junit 'mock-junit.xml'
                  archiveArtifacts artifacts: 'mock-artifact-*.txt', allowEmptyArchive: true, fingerprint: true
              }
            }
	  }
        }]})
