#!/bin/sh

[ -d /opt/puppet/bin ] && export PATH=/opt/puppet/bin:$PATH

gem install r10k --no-rdoc --no-ri -v 1.4.0
PUPPETFILE=/tmp/control/Puppetfile PUPPETFILE_DIR=/tmp/control/modules r10k puppetfile install --verbose
puppet apply /tmp/control/manifests --modulepath='/tmp/control/site:/tmp/control/modules:/opt/puppet/share/puppet/modules'
rm -rfv "$(puppet config print confdir)/environments"
mkdir -pv "$(puppet config print confdir)/environments"
r10k deploy environment -vp

mkdir -p /etc/puppetlabs/facter/facts.d
echo 'role=role::pe::master' > /etc/puppetlabs/facter/facts.d/role.txt
