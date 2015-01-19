### my r10k control repository

## requirements
- [Puppet Enterprise](http://puppetlabs.com/puppet/puppet-enterprise)
- [r10k](https://github.com/adrienthebo/r10k)

## vagrant
- [vagrant](https://www.vagrantup.com) version 1.5.0 or greater (while untested, versions prior to 1.5.0 should work if the Vagrantfile is changed to use non Vagrant Cloud boxes)
- [virtualbox](https://www.virtualbox.org) or vmware desktop and vagrant provider
- [vagrant-hosts plugin](https://github.com/adrienthebo/vagrant-hosts)
- [vagrant-auto_network plugin](https://github.com/adrienthebo/vagrant-auto_network)

## notes
since r10k only deploys branches to environments, [tags](https://github.com/awaxa/control/tags) are like remote stashes - not releases
