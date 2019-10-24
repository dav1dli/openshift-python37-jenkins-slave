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
    imgName = 'jenkins-slave-python37'
  }
  stages {
    stage('SCM') {
      steps {
        git url: 'https://github.com/dav1dli/openshift-python37-jenkins-slave.git'
      }
    }
    stage('Build') {
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
        script {
          openshift.withCluster() {
            openshift.withProject() {
              openshift.newApp("jenkins-slave-python37-template.yml")
            }
          }
        }
      }
    }
    stage('Tag') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject() {
              openshift.tag("${imgName}:v3.11", "${imgName}:latest")
            }
          }
        }
      }
    }
  }
}
