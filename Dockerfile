FROM ubuntu:trusty
MAINTAINER JAFB <jfrutos@gmail.com>

#Prevent dpkg errors
ENV TERM=xterm-256color

#Set mirrors to ES
RUN sed -i "s/http:\/\/archive./http:\/\/es.archive./g" /etc/apt/sources.list

#Install Python runtime
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

#Create virtual enviroment
# Upgrade PIP in virtual enviroment to latest version
RUN virtualenv /appenv && \
. /appenv/bin/activate && \
pip install pip --upgrade

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend
