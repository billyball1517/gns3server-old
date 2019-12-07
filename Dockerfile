FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common curl gosu \
    && add-apt-repository -y ppa:gns3/ppa \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt install -y gns3-server gns3-iou \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh
    
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /usr/bin/gns3server
