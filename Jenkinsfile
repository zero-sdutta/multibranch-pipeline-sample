parallel([0, 1, 2, 3, 4].collectEntries {b -> ["perfBranch-$b", {
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
        cpu: '256m'
        memory: '640Mi'
''') {
retry(count: 2, conditions: [kubernetesAgent(), nonresumable()]) {
              node(POD_LABEL) {
                stage("run-$b") {
		  sh "curl -o mock-load-builder.jar https://repo.jenkins-ci.org/artifactory/releases/org/jenkins-ci/plugins/mock-load-builder/105.v1fc7e407a_0b_1/mock-load-builder-105.v1fc7e407a_0b_1.jar"
                  sh "java -cp mock-load-builder.jar mock.MockLoad 1800"
                }
		stage("publish-$b"){
		  junit 'mock-junit.xml'
                  archiveArtifacts artifacts: 'mock-artifact-*.txt', allowEmptyArchive: true, fingerprint: true
              }
            }
	  }
	}
        }]})
