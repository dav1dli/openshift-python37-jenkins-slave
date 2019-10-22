# Openshift Jenkins slave with Python 3.7

This image is installed with Python 3.7.x runtime required by some components. The purpose is to have a Jenkins slave configration running Python tasks such as tests. Python 3.7.x is installed from sources. 
In the future when python 3.7 will be available as a package from supported repositories this configuration installing Python from sources could be simplified.

The configuration uses standard RHEL7 image as a baseline. The configuration installs python 3.7 and dependencies required to build it.

# Build the image locally

*Note:* _the process will require login to Red Hat docker registry hosting the base image._
```
docker build -t jenkins-slave-python37-rhel7 .
```

# Build the image on Openshift from the command line

```
git clone https://github.com/dav1dli/openshift-python37-jenkins-slave.git .
oc login -u developer
oc project sonarqube
cat Dockerfile | oc new-build --name docker build -t jenkins-slave-python37-rhel7 --dockerfile='-'
```
# Build the image on Openshift using template

```
oc process -f jenkins-slave-python37-template.yml | oc create -f -
```

# Jenkins build

TBD
