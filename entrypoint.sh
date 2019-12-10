#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd -m -s /usr/sbin/nologin -u $USER_ID -o user
export HOME=/home/user

groupadd -g $GROUP_ID -o group

usermod -aG ubridge user
usermod -aG libvirt user
usermod -aG group user

service libvirtd start

exec /usr/sbin/gosu user "$@"
