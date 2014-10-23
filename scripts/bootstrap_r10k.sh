#!/bin/sh

[ -z $1 ] && echo 'specify control remote in $1' && exit 1

/opt/puppet/bin/puppet resource package git ensure=present
/usr/bin/git clone $1 /tmp/control
/opt/puppet/bin/gem install r10k --no-rdoc --no-ri -v 1.3.0
PUPPETFILE=/tmp/control/Puppetfile PUPPETFILE_DIR=/tmp/control/modules /opt/puppet/bin/r10k puppetfile install
/opt/puppet/bin/puppet apply /tmp/control/manifests/master.pp --modulepath='/tmp/control/site:/tmp/control/modules:/opt/puppet/share/puppet/modules'
/opt/puppet/bin/r10k deploy environment -pv
