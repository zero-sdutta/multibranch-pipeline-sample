pipeline {
  agent {
	kubernetes {
	    yamlFile "podTemplates/kaniko_cbci.yaml"
            }
        }
  options {
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
  }
  stages {
    stage('Hello') {
      steps {
        sh '''
          java -version
        '''
      }
    }
    stage('cat README') {
      steps {
        sh '''
          cat README.md
        '''
      }
    }
  }
}
