FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common gosu locales curl\
    && locale-gen en_US.UTF-8 \
    && add-apt-repository -y ppa:gns3/ppa \
    && apt update \
    && apt install -y gns3-server \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
   
CMD /usr/bin/gns3server
