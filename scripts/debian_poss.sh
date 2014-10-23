#!/bin/sh

deb="puppetlabs-release-$(lsb_release -c -s).deb"
wget -nc --output-document=/tmp/$deb https://apt.puppetlabs.com/$deb
dpkg -i /tmp/$deb
apt-get update
apt-get -y install puppet
