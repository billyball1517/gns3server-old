FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common
    
RUN add-apt-repository -y ppa:gns3/ppa

RUN apt update && apt install -y \
    locales \
    python3-pip \
    qemu-system-x86 \
    qemu-kvm \
    libvirt-bin \
    x11vnc \
    curl

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh

RUN locale-gen en_US.UTF-8

RUN apt update && apt install -y vpcs ubridge

RUN pip3 install gns3-server

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD tail -f /dev/null
