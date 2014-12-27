# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.pe_build.version = '3.7.1'
  config.pe_build.download_root = 'http://s3.amazonaws.com/pe-builds/released/:version'

  config.vm.define :master do |master|
    master.vm.box = 'puppetlabs/centos-6.5-64-nocm'
    master.vm.provider 'virtualbox' do |vb|
      vb.customize ['modifyvm', :id, '--memory', '4096']
      vb.customize ['modifyvm', :id, '--cpus', '1']
    end
    master.vm.provider 'vmware_fusion' do |v|
      v.vmx['memsize'] = '4096'
      v.vmx['numvcpus'] = '1'
    end
    master.vm.network :private_network, :auto_network => true
    master.vm.provision :hosts
    master.vm.provision :pe_bootstrap do |pe|
      pe.role = :master
    end
    master.vm.provision 'shell',
      inline: "/opt/puppet/bin/puppet apply --exec 'service {'iptables': ensure => 'stopped', enable => false }'"
    master.vm.provision 'shell', path: 'scripts/bootstrap_r10k.sh'
  end

  config.vm.define :agent do |agent|
    agent.vm.box = 'puppetlabs/centos-6.5-64-nocm'
    agent.vm.network :private_network, :auto_network => true
    agent.vm.provision :hosts
    agent.vm.provision :pe_bootstrap
  end

  config.vm.define :workstation, autostart: false do |workstation|
    workstation.vm.box = 'puppetlabs/ubuntu-14.04-64-nocm'
    unless ENV['GUI'] == 'true'
      workstation.vm.provider 'virtualbox' do |vb|
        vb.gui = true
      end
      workstation.vm.provider 'vmware_fusion' do |v|
        v.gui = true
      end
    end
    workstation.vm.provision 'shell', path: 'scripts/debian_poss.sh'
    workstation.vm.provision 'shell', path: 'scripts/bootstrap_r10k.sh'
    workstation.vm.provision 'shell', path: 'scripts/bootstrap_workstation.sh'
  end
end
