#!/bin/sh

[ -d /opt/puppet/bin ] && export PATH=/opt/puppet/bin:$PATH

puppet resource package git ensure=present
git clone https://github.com/awaxa/control.git /tmp/control
gem install r10k --no-rdoc --no-ri -v 1.4.0
PUPPETFILE=/tmp/control/Puppetfile PUPPETFILE_DIR=/tmp/control/modules r10k puppetfile install --verbose
puppet apply /tmp/control/manifests --modulepath='/tmp/control/site:/tmp/control/modules:/opt/puppet/share/puppet/modules'
r10k deploy environment -pv
