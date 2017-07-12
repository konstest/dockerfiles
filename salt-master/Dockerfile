FROM ubuntu:16.04

ENV APT_OPTS --no-install-recommends -y
ENV SALT_REPO http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest

RUN apt-get update && apt-get install $APT_OPTS curl ca-certificates && \
    curl https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb $SALT_REPO xenial main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && \
    apt-get upgrade $APT_OPTS && \
    apt-get install $APT_OPTS \
                    salt-api \
                    salt-master \
                    salt-minion \
                    salt-syndic \
                    salt-cloud \
                    salt-ssh \
                    inetutils-telnet \
                    dnsutils \
                    python-pip \
                    python-pygit2 \
                    python-setuptools \
                    vim \
                    mc \
                    git \
                    inetutils-ping \
                    iproute2 && \
    pip2 install --upgrade pip wheel pyVmomi cherrypy pywinrm impacket

RUN HUB=`host github.com | grep 'has address' | head -n1 | awk '{print $4}'`; \
    echo "$HUB    github-second-record.com" >> /etc/hosts

ADD gitfs.conf /etc/salt/master.d/
ADD file_roots.conf /etc/salt/master.d/
RUN echo "master: localhost" > /etc/salt/minion.d/master-address.conf; \
    echo "role: salt-master" > /etc/salt/grains

ADD run.sh /usr/local/etc/
RUN chmod +x /usr/local/etc/run.sh

#RUN apt-get remove $APT_OPTS salt-cloud && curl -o bootstrap_salt.sh -L https://bootstrap.saltstack.com && sh bootstrap_salt.sh -XL git

# Ports
EXPOSE 22 4505 4506

VOLUME ["/etc/salt/pki"]
