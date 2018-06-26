FROM python:3.6-alpine3.7

# datomic-socks-proxy requires AWS CLI
RUN pip install awscli --upgrade

# Download datomic-socks-proxy
RUN wget -O datomic-socks-proxy 'https://docs.datomic.com/cloud/files/datomic-socks-proxy' && \
    chmod +x datomic-socks-proxy

# Install bash and openssh
RUN apk update
RUN apk upgrade
RUN apk add bash openssh

# We need to set the ssh_config to not ask about adding an IP to known_hosts
ADD ssh_config /etc/ssh/

ENTRYPOINT ["bash", "datomic-socks-proxy"]