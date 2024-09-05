parallel([0, 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19].collectEntries {b -> ["perfBranch-$b", {
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

              node(POD_LABEL) {
                stage("build-$b") {
                  withMockLoad(averageDuration: 120) {
                    sh 'eval $MOCK_LOAD_COMMAND || echo "Failed: $?"'
                  }
                }
                stage("publish-$b") {
                  junit 'mock-junit.xml'
                  archiveArtifacts artifacts: 'mock-artifact-*.txt', allowEmptyArchive: true, fingerprint: true
                }
              }
            }
        }]})
