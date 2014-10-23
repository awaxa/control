#!/bin/sh

[ -z $1 ] && echo 'specify control remote in $1' && exit 1

puppet resource package git ensure=present
git clone $1 /tmp/control
gem install r10k --no-rdoc --no-ri -v 1.3.0
PUPPETFILE=/tmp/control/Puppetfile PUPPETFILE_DIR=/tmp/control/modules r10k puppetfile install
puppet apply --execute 'include role::workstation' --modulepath='/tmp/control/site:/tmp/control/modules'
r10k deploy environment -pv
facter is_virtual | grep -q true && puppet resource user vagrant password='$6$w26kYwUf$lwsr9fpifv.rrnY4xBOtbcZAuhjlbhHktEI7rhWaCdm0UZkdm/MXRMQpgMmTdQUp64ccgHgANspgwJrYsuYjz.'
start lightdm
