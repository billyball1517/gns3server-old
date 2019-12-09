FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:gns3/ppa
RUN apt-get update && apt-get install -y \
    locales \
    python3-pip \
    qemu-system-x86 \
    qemu-system-arm \
    qemu-kvm \
    libvirt-bin \
    x11vnc \
    curl
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh

RUN locale-gen en_US.UTF-8

RUN apt-get install -y vpcs ubridge

RUN pip3 install gns3-server
