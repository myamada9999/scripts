#!/bin/bash

# install lxde, if you change Desktop from GNOME to LXDE
FROM_GNOME_TO_LXDE=1
# reboot after install was completed
REBOOT=1

function abort
{
	echo "ERROR: $@" 1>&2
	exit 1
}

# install remote desktop
sudo apt-get install -y xrdp
sudo systemctl enable xrdp.service
sudo systemctl start xrdp.service

# install japanese keymap files
cd /tmp
[ ! `which wget` ] && abort "wget command not found."
wget http://w.vmeta.jp/temp/km-0411.ini
cd /etc/xrdp
[ ! -f km-0411.ini ]     && sudo cp /tmp/km-0411.ini .
[ ! -f km-e0200411.ini ] && sudo ln -s km-0411.ini km-e0200411.ini
[ ! -f km-e0010411.ini ] && sudo ln -s km-0411.ini km-e0010411.ini
sudo rm /tmp/km-0411.ini

# install lxde, if you change Desktop from GNOME to LXDE
if [ $FROM_GNOME_TO_LXDE == 1 ]; then
    sudo aptitude purge -y `dpkg --get-selections | grep gnome | cut -f 1`
    sudo aptitude -f install -y
    sudo aptitude purge -y `dpkg --get-selections | grep deinstall | cut -f 1`
    sudo aptitude -f install -y
    sudo apt-get install -y lxde lightdm
    sudo apt-get install -y sudo network-manager
    sudo systemctl enable lightdm.service
    echo "lxsession -s LXDE -e LXDE" > ~/.xsession
fi

[ $REBOOT == 1 ] && sudo reboot
