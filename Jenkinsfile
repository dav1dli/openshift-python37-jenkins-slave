pipeline {
  agent {
    node {
      label 'master'
    }
  }
  options {
    timeout(time: 10, unit: 'MINUTES')
  }
  environment {
    imgName = 'openshift-python37-jenkins-slave'
  }
  stages {
    stage('SCM') {
      steps {
        git url: 'https://github.com/dav1dli/openshift-python37-jenkins-slave.git'
      }
    }
    stage('NewBuild') {
      when {
        expression {
          openshift.withCluster() {
            openshift.withProject() {
              return !openshift.selector("bc", "${imgName}").exists();
            }
          }
        }
      }
      steps {
        sh '''
          cat Dockerfile | oc new-build --name "${imgName}" --dockerfile='-'
          oc secrets link default 11009103-dliderma-pull-secret --for=pull
          oc secrets add serviceaccount/builder secrets/11009103-dliderma-pull-secret
        '''
      }
    }
    stage('Build') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject('sonarqube') {
              openshift.selector("bc", "${imgName}").startBuild("--from-dir=.", "--wait=true")
            }
          }
        }
      }
    }
  }
}
