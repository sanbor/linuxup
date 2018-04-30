#!/bin/bash

# Kind of automated linux web development Ubuntu 18.04 setup.
# This script has never been runned for real.
#
# Based on [Sojharo's Development Machine Setup on Ubuntu](https://github.com/sojharo/mangi-script/)
#

# Go to software repo options and
# set software sources to server for united states
#

# Exit when some command fails (more info http://www.davidpashley.com/articles/writing-robust-shell-scripts/#id2382181)
set -e

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

sudo apt-get update

sudo apt-get upgrade

# Installing build essentials
sudo apt install -y build-essential libssl-dev

# Useful stuff
sudo apt install -y git vim zsh openconnect autojump tor openvpn ranger \
  mplayer espeak ipython jupyter pass syncthing htop

# Archive Extractors
sudo apt install -y unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

# GUI apps
sudo apt install -y gnome-tweaks filezilla vlc gimp gimp-data gimp-plugin-registry gimp-data-extras

# Dictionary Client and Server with Thesaurus
sudo apt-get install -y dict dictd dict-gcide dict-wn dict-devil dict-moby-thesaurus

# Java
sudo apt-get install -y default-jdk maven

# Docker
sudo snap install docker

# Docker-compose
sudo pip install docker-compose

# Google Chrome
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

# Atom
curl -L https://atom.io/download/deb -o atom-amd64.deb
sudo dpkg -i atom-amd64.deb
sudo apt-get -f install

# Install ubuntu-make in order to install firefox dev edition, intellij idea and eclipse
sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt install -y ubuntu-make
umake ide nodejs
umake web firefox-dev
umake ide idea-ultimate
umake ide eclipse-jee

# Gulp - an automated task runner
npm install -g gulp-cli

echo "Please enter your full name to be used in git config:"
read name

echo "Please enter email to generate ssh key and to be set in git config:"
read email

# Create keys for the machine
mkdir ~/.ssh || true
ssh-keygen -t rsa -b 4096 -C "$email"
eval "$(ssh-agent -s)"
mv ~/.ssh/.ssh_config ~/.ssh/.ssh_config.back || true # Try to backup just in case
ssh-add ~/.ssh/id_rsa

# Setup git
cp ~/.gitconfig ~/.gitconfig.bak || true # Try to backup just in case
cp ./dot.gitconfig ~/.gitconfig
cp ~/.gitignore ~/.gitignore.bak || true # Try to backup just in case
cp ./dot.gitignore ~/.gitignore
git config --global user.name "$name"
git config --global user.email "$email"
git config --global core.editor vim
git config --list

# Setup zsh (more info https://wiki.archlinux.org/index.php/zsh)
cp ~/.zshrc ~/.zshrc.bak || true # Try to backup just in case
cp ./dot.zshrc ~/.zshrc

# Setup vim
cp ~/.vimrc ~/.vimrc.bak || true # Try to backup just in case
cp ./dot.vimrc ~/.vimrc

# Set zsh as default
chsh -s $(which zsh)

# log out of your computer and log back in
