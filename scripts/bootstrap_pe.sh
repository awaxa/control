#!/bin/sh

PE_VERSION='3.7.1'
PLATFORM='el-6-x86_64'
# PLATFORM='ubuntu-14.04-amd64'
TARBALL="puppet-enterprise-$PE_VERSION-${PLATFORM}.tar.gz"
TMPDIR='/tmp/puppet-enterprise'
# TMPDIR=$(mktemp -d)

curl -o /tmp/$TARBALL https://s3.amazonaws.com/pe-builds/released/$PE_VERSION/$TARBALL
mkdir -p $TMPDIR
tar -xzf /tmp/$TARBALL --directory=$TMPDIR --strip-components=1

curl -o $TMPDIR/answers.txt https://raw.githubusercontent.com/awaxa/control/production/answers.txt
$TMPDIR/puppet-enterprise-installer -A $TMPDIR/answers.txt
