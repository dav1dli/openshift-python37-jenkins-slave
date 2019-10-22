pipeline {
  agent {
    node {
      label 'master'
    }
  }
  options {
    timeout(time: 10, unit: 'MINUTES')
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
            openshift.withProject('sonarqube') {
              return !openshift.selector("bc", "openshift-python37-jenkins-slave").exists();
            }
          }
        }
      }
      steps {
        sh '''
          cat Dockerfile | oc new-build --name openshift-python37-jenkins-slave --dockerfile='-'
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
              openshift.selector("bc", "openshift-python37-jenkins-slave").startBuild("--from-dir=.", "--wait=true")
            }
          }
        }
      }
    }
  }
}
