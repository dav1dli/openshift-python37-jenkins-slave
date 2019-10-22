FROM registry.redhat.io/openshift3/jenkins-slave-base-rhel7
LABEL com.redhat.component="jenkins-agent-python-rhel7-container" \
      name="jenkins-agent-python-rhel7" \
      version="3.7" \
      architecture="x86_64" \
      io.k8s.display-name="Jenkins Agent Python" \
      io.k8s.description="The jenkins build agent Python" \
      io.openshift.tags="openshift,jenkins,agent,python,python3,builder"

ENV PYTHON_VERSION=3.7

RUN INSTALL_PKGS="gcc openssl-devel bzip2-devel libffi-devel make wget" && \
    yum install -y --disablerepo=rhel-7-server-htb-rpms --enablerepo=rhel-server-rhscl-7-rpms --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    rm -rf /var/cache/yum && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar xzf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm /usr/src/Python-3.7.4.tgz && \
    ln -s /usr/local/bin/python3.7 /usr/bin/python3 && \
    ln -s /usr/local/bin/pip3.7 /usr/bin/pip3 && \
    pip3 install --upgrade pip && \
    pip3 install pipenv && \
    chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
