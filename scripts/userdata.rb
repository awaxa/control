#!/usr/bin/env ruby

require 'erb'

@pe_username = 'admin'
@pe_password = 'puppetlabs'
@pe_version_string = '3.7.1'
@pe_altnames = 'puppet.awaxa.com,puppet'
@cloud = ENV['CLOUD']

def userdata(vm)
  ERB.new(File.new("site/profile/templates/#{vm}-pe-userdata.erb").read, nil, '%').result()
end

ENV['vm'] ||= 'master'
puts userdata(ENV['vm'])
