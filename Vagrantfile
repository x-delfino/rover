# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

VAR_FILE = 'vagrant/vars.json'

file = File.read(VAR_FILE)
vars = JSON.parse(file)

Vagrant.configure('2') do |config|
  vars['hosts'].each do |host|
    config.vm.define host['name'] do |guest|
      guest.ssh.forward_agent = host['ssh_agent'] if host['ssh_agent']
      guest.vm.box = host['box']
      guest.vm.hostname = host['hostname']
      guest.vm.provider 'parallels' do |prl|
        prl.name = host['hostname']
        prl.cpus = host['cpus']
        prl.memory = host['memory']
        prl.customize ['set', :id]
        prl.update_guest_tools = true
      end
      host['playbooks']&.each do |playbook|
        ans_groups = {}
        ans_vars = {}
        playbook['groups']&.each { |g| ans_groups[g] = [host['name']] }
        playbook['vars']&.each { |v| ans_vars[v.keys.first] = v[v.keys.first] }
        guest.vm.provision 'ansible' do |ansible|
          ansible.playbook = playbook['path']
          ansible.groups = ans_groups unless ans_groups.empty?
          ansible.host_vars = { host['name'] => ans_vars } unless ans_vars.empty?
          ansible.galaxy_role_file = playbook['galaxy_file'] unless playbook['galaxy_file'].nil?
        end
      end
    end
  end
end
