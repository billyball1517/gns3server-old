FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y software-properties-common gosu locales curl \
    && locale-gen en_US.UTF-8 \
    && add-apt-repository -y ppa:gns3/ppa \
    && add-apt-repository -y ppa:projectatomic/ppa \
    && apt update \
    && apt install -y gns3-server podman \
    && sudo mkdir /etc/containers \
    && curl https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf \
    && curl https://raw.githubusercontent.com/containers/skopeo/master/default-policy.json -o /etc/containers/policy.json \
    && ln -s /usr/bin/podman /usr/bin/docker
    
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /usr/bin/gns3server
