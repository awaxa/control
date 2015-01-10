#!/bin/sh

[ -d /opt/puppet/bin ] && export PATH=/opt/puppet/bin:$PATH

puppet resource package git ensure=present
git clone https://github.com/awaxa/control.git /tmp/control
