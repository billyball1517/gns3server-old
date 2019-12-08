# billyball1517/gns3server
# Introduction

NOTES:

- This image not support nested docker containers or IOU images. QEMU/KVM only!
- This image is only the "server" component of GNS3, for the GUI component, I recommend pip3 (ie. sudo pip3 install gns3-gui), more info here: https://docs.gns3.com/1QXVIihk7dsOL7Xr7Bmz4zRzTsJ02wklfImGuHwTlaA4/index.html#h.xo8m7q5xitv6

I created this to use "GNS3" on .rpm based distros (RHEL, CentOS, Fedora, Suse, etc.). While there are ports to most of these systems, they are often broken or lag behind.

The container installs gns3-server, creates a dummy "user" account, mounts the dummy user /home folder to the specified local folder, and runs the server as that user.

# Steps

For QEMU/KVM to work, the dummy user needs to be able to access /dev/kvm on the host machine. To do this we need to know the GID of the "kvm" group on the host. Execute:

`grep kvm /etc/group`

And you will get an output similar to:

`kvm:x:130:`

If the above command dosn't work, don't panic. Depending on your setup, the "kvm" group might not exist. Unfortunatly, the kvm group needs to exist on the host in order to proceed. Typically this means that the qemu-kvm package needs to be installed on the host. To do that on an .rpm based system execute:

`yum install -y qemu-kvm`

And then repeat the previous step.

So we know the GID for /dev/kvm is "130"

Next, we need to make a gns3 user on the local machine.

`useradd -m -s /usr/sbin/nologin gns3`

We need to know the UID and home folder for the gns3 user. Execute:

`grep gns3 /etc/passwd`

And you will get an output similar to:

`gns3:x:1001:1001::/home/gns3:/usr/sbin/nologin`

So we know the UID for the user gns3 is "1001" and the home folder is "/home/gns3"

Finally, execute the following command, remembering to substitute the values you found out in the previous steps:

`docker run -d --name=gns3_session --network=host --restart=always --privileged -e LOCAL_USER_ID=<localuserid> -e LOCAL_GROUP_ID=<localgroupid> -v <localfolder>:/home/user billyball1517/gns3server`

`docker run -d --name=gns3_session --network=host --restart=always --privileged -e LOCAL_USER_ID=1001 -e LOCAL_GROUP_ID=130 -v /home/gns3:/home/user billyball1517/gns3server`

Since the gns3 data is made persistent in the /home/gns3 folder, upgrading is easy. Simply delete the running container, pull the image again, and start the container with the same command you used previously.

# ADDITIONAL INFO

Make sure the path when creating projects is `/home/user/......`  rather than whatever local user account.
