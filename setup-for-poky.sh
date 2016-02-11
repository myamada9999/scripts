#!/bin/sh

# This script is set up poky build environment for Debina/Ubuntu.

# Essentials
sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat 

# Graphical and Sclipse Plug-In Extras:
sudo apt-get install -y libsdl1.2-dev xterm

# Documentation
sudo apt-get install -y make xsltproc docbook-utils fop dblatex xmlto

# ADT Installer Extras
sudo apt-get install -y autoconf automake libtool libglib2.0-dev libarchive-dev

# OpenEmbedded Self-Test
sudo apt-get install -y python-git
