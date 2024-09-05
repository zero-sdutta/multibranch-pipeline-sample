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
        memory: '640Mi'
''') {
retry(count: 2, conditions: [kubernetesAgent(), nonresumable()]) {
              node(POD_LABEL) {
                stage("build-$b") {
                    sh 'java -version'
                }
                stage("publish-$b") {
                  sh 'cat README.md'
                }
              }
            }
	  }
        }]})
