# -*- mode: ruby -*-
# vi: set ft=ruby :

mem = '2048'
cpu = '2'

require 'erb'

@pe_username = 'admin'
@pe_password = 'puppetlabs'
@pe_version_string = '3.7.2'
@cloud = 'vagrant'

def userdata(vm)
  ERB.new(File.new("site/profile/templates/#{vm}-pe-userdata.erb").read, nil, '%').result()
end

Vagrant.configure(2) do |config|
  config.vm.define :master do |master|
    master.vm.box = 'puppetlabs/centos-6.5-64-nocm'
    master.vm.provider :virtualbox do |v|
      v.customize ['modifyvm', :id, '--memory', mem]
      v.customize ['modifyvm', :id, '--cpus', cpu]
    end
    master.vm.provider :vmware_fusion do |v|
      v.vmx['memsize'] = mem
      v.vmx['numvcpus'] = cpu
    end
    master.vm.network :private_network, :auto_network => true
    master.vm.provision :hosts
    master.vm.provision 'shell', inline: userdata('master')
  end

  config.vm.define :agent do |agent|
    agent.vm.box = 'puppetlabs/centos-6.5-64-nocm'
    agent.vm.network :private_network, :auto_network => true
    agent.vm.provision :hosts
    agent.vm.provision 'shell', inline: userdata('agent')
  end
end
