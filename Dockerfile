FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common curl gosu \
    && add-apt-repository -y ppa:gns3/ppa \
    && apt install -y gns3-server \
    && apt install -y locales \
    && locale-gen en_US.UTF-8
    
# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /usr/bin/gns3server
