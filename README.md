```
git clone https://github.com/dav1dli/openshift-python37-jenkins-slave.git .
oc login -u developer
oc project sonarqube
cat Dockerfile | oc new-build --name py37-docker --dockerfile='-'
```
