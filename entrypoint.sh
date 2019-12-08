#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd -m -s /bin/bash -u $USER_ID -o user
export HOME=/home/user

usermod -aG ubridge user
usermod -aG libvirt user
usermod -aG kvm user
usermod -aG docker user

service docker start
service libvirtd start

exec /usr/sbin/gosu root "$@"
