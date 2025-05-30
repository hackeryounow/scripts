sudo add-apt-repository ppa:martinx/xrdp-hwe-18.04
sudo apt-get update
sudo apt-get install xrdp xorg -y
# slove black screen problem
sudo sh -c 'cat << EOF >> /etc/xrdp/startwm.sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
EOF'


# set desktop icons
cat << EOF >> ~/.xsessionrc
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
EOF


# restart xrdp service
sudo systemctl restart xrdp.service