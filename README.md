# billyball1517/chrome-remote-desktop

# Introduction

NOTES: - This image not support nested docker containers or IOU images. QEMU/KVM only!
       - This image is only the "server" component of GNS3, for the GUI component, I reccomend pip3 (ie. sudo pip3 install gns3-gui), more info here: https://docs.gns3.com/1QXVIihk7dsOL70Xr7Bmz4zRzTsJ02wklfImGuHwTlaA4/index.html#h.xo8m7q5xitv6

I created this to use "GNS3" on .rpm based distros (RHEL, CentOS, Fedora, Suse, etc.). While there are ports to most of these systems, they are often broken or lag behind.

The container installs gns3-server, creates a dummy "user" account, mounts the dummy user /home folder to the specified local folder, and runs the server as that user.

# Steps

For QEMU/KVM to work, the dummy user needs to be able to access /dev/kvm on the host machine. To do this we need to know the UID of the "kvm" group on the host.

`grep kvm /etc/groups`

`docker run -d --name=gns3_session --network=host --restart=always --privileged -e LOCAL_USER_ID=1001 -e LOCAL_GROUP_ID=130 -v /home/gns3:/home/user billyball1517/gns3server`
