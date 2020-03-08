FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common gosu locales \
    && locale-gen en_US.UTF-8 \
    && add-apt-repository -y ppa:gns3/ppa \
    && apt update \
    && apt install -y gns3-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /usr/bin/gns3server
